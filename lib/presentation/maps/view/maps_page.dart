// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:attendance_app/l10n/l10n.dart';
import 'package:attendance_app/presentation/maps/maps.dart';
import 'package:attendance_app/presentation/maps/view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key, this.latLng}) : super(key: key);

  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: MapPageView(latLng: latLng),
    );
  }
}

class MapPageView extends StatelessWidget {
  const MapPageView({Key? key, this.latLng}) : super(key: key);

  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.mapAppBarTitle)),
        body: Center(
            child: MapView(
          l10n: l10n,
          latLng: latLng,
        )));
  }
}
