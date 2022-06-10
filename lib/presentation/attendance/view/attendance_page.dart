// ignore_for_file: use_build_context_synchronously

import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/core/platform/current_location.dart';
import 'package:attendance_app/data/response/attendance_list_model.dart';
import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:attendance_app/presentation/attendance/view/attendance_history.dart';
import 'package:attendance_app/presentation/widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final locationBox = Hive.box<LocationListModel>(KeyConstant.keyLocationBox);
  final attendanceBox =
      Hive.box<AttendanceHistoryListModel>(KeyConstant.keyAttendanceHistoryBox);

  LocationListModel? location;
  List<HistoryListData>? historyList = [];

  final isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    location = locationBox.get(KeyConstant.keyLocationBox);
    historyList =
        attendanceBox.get(KeyConstant.keyAttendanceHistoryBox)?.history ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Attendance'), actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                  onTap: () => Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (context) => const AttendanceHistory(),
                      )),
                  child: Row(
                    children: const [Icon(Icons.history), Text('History')],
                  )),
            )
          ]),
          body: location == null
              ? const Center(
                  child: Text('Location is empty'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                        trailing: const Text('Tap to attend'),
                        title: Text(
                            location?.locationList?[index].locationName ?? ''),
                        onTap: () => onAttendanceTap(
                            LatLng(location!.locationList![index].latitude!,
                                location!.locationList![index].longitude!),
                            location?.locationList?[index].locationName ?? ''));
                  },
                  separatorBuilder: (_, i) => const Divider(height: 0),
                  itemCount: location?.locationList?.length ?? 0),
        ),
        ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, widget) {
              if (isLoading.value) {
                return const LoaderWidget();
              } else {
                return const SizedBox.shrink();
              }
            })
      ],
    );
  }

  Future<void> onAttendanceTap(LatLng latLng, String locationName) async {
    isLoading.value = true;
    final currentLocation = await CurrentLocation.getPosition();

    final distance = Geolocator.distanceBetween(latLng.latitude,
        latLng.longitude, currentLocation.latitude, currentLocation.longitude);

    if (distance <= 50) {
      final list = historyList;

      final now = DateTime.now();

      list!.add(HistoryListData(
          locationData: LocationDataModel(
              latitude: latLng.latitude,
              longitude: latLng.longitude,
              locationName: locationName),
          time: now));

      await attendanceBox
          .put(KeyConstant.keyAttendanceHistoryBox,
              AttendanceHistoryListModel(history: list))
          .then((value) {
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Attendance Successfully'),
            padding: EdgeInsets.all(16),
            backgroundColor: Colors.black54,
            margin: EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating));
      });
    } else {
      isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Attendance Fail, try another location'),
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.black54,
        margin: EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
