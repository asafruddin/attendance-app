import 'dart:async';

import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/core/platform/current_location.dart';
import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:attendance_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key, required this.l10n, this.latLng}) : super(key: key);
  final AppLocalizations l10n;
  final LatLng? latLng;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(-6.2295712, 106.7594781), zoom: 12);
  final Completer<GoogleMapController> _controller = Completer();
  final box = Hive.box<LocationListModel>(KeyConstant.keyLocationBox);

  BitmapDescriptor? _markerIcon;

  LatLng _lastPos = const LatLng(-6.2295712, 106.7594781);
  String address = '';
  List<LocationDataModel> locationData = [];

  Future<void> getCurrentPosittion() async {
    final controller = await _controller.future;
    final currentLocation = await CurrentLocation.getPosition();

    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 17)));

    setState(() {
      _lastPos = LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    await getAddress();
  }

  @override
  void initState() {
    super.initState();

    locationData = box.get(KeyConstant.keyLocationBox)?.locationList ?? [];
    if (widget.latLng != null) {
      onMapTap(widget.latLng!);
    } else {
      getCurrentPosittion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onTap: onMapTap,
            markers: <Marker>{_createMarker()},
            onMapCreated: _controller.complete),
        if (address.isNotEmpty)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Data Lokasi',
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 8),
                  Text(address),
                  if (widget.latLng == null)
                    ElevatedButton(
                      onPressed: () {
                        final list = locationData;
                        // ignore: cascade_invocations
                        list.add(LocationDataModel(
                            latitude: _lastPos.latitude,
                            longitude: _lastPos.longitude,
                            locationName: address));

                        box
                            .put(KeyConstant.keyLocationBox,
                                LocationListModel(locationList: list))
                            .then((value) => Navigator.pop(context));
                      },
                      style:
                          ButtonStyle(elevation: MaterialStateProperty.all(0)),
                      child: const Text('Save'),
                    )
                ],
              ),
            ),
          )
      ],
    );
  }

  Future<void> getAddress() async {
    final coordinates = Coordinates(_lastPos.latitude, _lastPos.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      address = addresses.first.addressLine!;
    });
  }

  Future<void> onMapTap(LatLng latLng) async {
    final controller = await _controller.future;

    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latLng.latitude, latLng.longitude), zoom: 17)));

    setState(() {
      _lastPos = LatLng(latLng.latitude, latLng.longitude);
    });

    await getAddress();
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _lastPos,
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _lastPos,
      );
    }
  }
}
