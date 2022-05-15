// ignore_for_file: join_return_with_assignment

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class CurrentLocation {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;

    late Position position;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await enableLocationService().then((value) async {
        if (value) {
          position = await getPosition();
        }
      });
      return position;
    } else {
      position = await getPosition();
      return position;
    }
  }

  static Future<Position> getPosition() async {
    PermissionStatus permission;
    permission = await requestPermission();

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Perizinan lokasi tidak disetujui secara permanen');
    }

    if (permission == LocationPermission.denied) {
      return Future.error('Perizinan lokasi tidak disetujui');
    } else {
      final position = await Geolocator.getCurrentPosition();
      return position;
    }
  }

  static Future<bool> enableLocationService() async {
    final location = Location();
    final isEnabled = await location.requestService();

    if (isEnabled) {
      return isEnabled;
    } else {
      await enableLocationService();
    }

    return false;
  }

  static Future<PermissionStatus> requestPermission() async {
    PermissionStatus permission;
    Location location = Location();

    permission = await location.hasPermission();

    if (permission == PermissionStatus.denied) {
      location.requestPermission().then((value) {
        if (value == PermissionStatus.denied) {
          requestPermission();
        }
        return value;
      });
    }
    return PermissionStatus.granted;
  }
}
