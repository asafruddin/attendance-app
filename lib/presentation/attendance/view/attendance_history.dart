import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/data/response/attendance_list_model.dart';
import 'package:attendance_app/presentation/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({Key? key}) : super(key: key);

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  final attendanceBox =
      Hive.box<AttendanceHistoryListModel>(KeyConstant.keyAttendanceHistoryBox);

  AttendanceHistoryListModel? _attendanceHistoryListModel;

  @override
  void initState() {
    super.initState();
    _attendanceHistoryListModel =
        attendanceBox.get(KeyConstant.keyAttendanceHistoryBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Attendance History')),
        body: ValueListenableBuilder(
            valueListenable: attendanceBox.listenable(),
            builder: (context, value, widget) {
              final historyList =
                  attendanceBox.get(KeyConstant.keyAttendanceHistoryBox);

              if (historyList == null) {
                return const Center(child: Text('No Attendance Yet'));
              }
              return ListView.separated(
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () => Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (context) => MapPage(
                                  latLng: LatLng(
                                      historyList
                                          .history![i].locationData!.latitude!,
                                      historyList.history![i].locationData!
                                          .longitude!)))),
                      subtitle: Text(
                          historyList.history?[i].locationData?.locationName ??
                              ''),
                      title: Text(DateFormat('EEEE, dd MMMM yyyy - HH:mm')
                          .format(historyList.history![i].time!)),
                      trailing: Icon(Icons.location_history,
                          color: Theme.of(context).primaryColor),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemCount: historyList.history?.length ?? 0);
            }));
  }
}
