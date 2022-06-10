import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'attendance_list_model.g.dart';

@HiveType(typeId: 2)
class AttendanceHistoryListModel extends Equatable {
  const AttendanceHistoryListModel({this.history});

  @HiveField(0)
  final List<HistoryListData>? history;

  @override
  List<Object?> get props => [history];
}

@HiveType(typeId: 3)
class HistoryListData extends Equatable {
  const HistoryListData({this.locationData, this.time});

  @HiveField(0)
  final LocationDataModel? locationData;
  @HiveField(1)
  final DateTime? time;

  @override
  List<Object?> get props => [locationData, time];
}
