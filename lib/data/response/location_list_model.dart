import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'location_list_model.g.dart';

@HiveType(typeId: 0)
class LocationListModel extends Equatable {
  const LocationListModel({this.locationList});

  @HiveField(0)
  final List<LocationDataModel>? locationList;

  @override
  List<Object?> get props => [locationList];
}

@HiveType(typeId: 1)
class LocationDataModel extends Equatable {
  const LocationDataModel({this.longitude, this.latitude, this.locationName});

  @HiveField(0)
  final String? longitude;
  @HiveField(1)
  final String? latitude;
  @HiveField(2)
  final String? locationName;

  @override
  List<Object?> get props => [longitude, latitude, locationName];
}
