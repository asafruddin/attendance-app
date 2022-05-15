import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/core/platform/current_location.dart';
import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final box = Hive.box<LocationListModel>(KeyConstant.keyLocationBox);
  LocationListModel? location;

  @override
  void initState() {
    super.initState();
    location = box.get(KeyConstant.keyLocationBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: location == null
          ? const Center(
              child: Text('Location is empty'),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    trailing: const Text('Tap to attend'),
                    title:
                        Text(location?.locationList?[index].locationName ?? ''),
                    onTap: () => onAttendanceTap(LatLng(
                        location!.locationList![index].latitude!,
                        location!.locationList![index].longitude!)));
              },
              separatorBuilder: (_, i) => const SizedBox(),
              itemCount: location?.locationList?.length ?? 0),
    );
  }

  Future<void> onAttendanceTap(LatLng latLng) async {
    final currentLocation = await CurrentLocation.getPosition();

    final distance = Geolocator.distanceBetween(latLng.latitude,
        latLng.longitude, currentLocation.latitude, currentLocation.longitude);

    if (distance <= 50) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance Successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Attendance Fail, try another location')));
    }
  }
}
