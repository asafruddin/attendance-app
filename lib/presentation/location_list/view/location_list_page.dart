import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:attendance_app/l10n/l10n.dart';
import 'package:attendance_app/presentation/attendance/view/attendance_page.dart';
import 'package:attendance_app/presentation/location_list/view/add_location_page.dart';
import 'package:attendance_app/presentation/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({Key? key}) : super(key: key);

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final box = Hive.box<LocationListModel>(KeyConstant.keyLocationBox);
  LocationListModel? location;

  @override
  void initState() {
    super.initState();
    location = box.get(KeyConstant.keyLocationBox);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
        appBar: AppBar(
          title: Text(l10n.locationListAppBarTitle),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                    onTap: () => Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (context) => const AttendancePage(),
                        )),
                    child: Row(
                      children: const [Icon(Icons.check), Text('Attendance')],
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            onPressed: () => Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (context) => const AddLocationPage()))
                .then((dynamic value) => box.get(KeyConstant.keyLocationBox)),
            child: const Icon(Icons.add)),
        body: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, widget) {
              final locList = box.get(KeyConstant.keyLocationBox);

              if (locList == null) {
                return const Center(child: Text('Location is empty'));
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: const Icon(Icons.chevron_right_rounded),
                      title:
                          Text(locList.locationList?[index].locationName ?? ''),
                      onTap: () => Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (context) => MapPage(
                              latLng: LatLng(
                                  locList.locationList![index].latitude!,
                                  locList.locationList![index].longitude!),
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(),
                  itemCount: locList.locationList?.length ?? 0);
            }));
  }
}
