import 'package:attendance_app/l10n/l10n.dart';
import 'package:attendance_app/presentation/maps/view/map_view.dart';
import 'package:flutter/material.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Location')),
      body: MapView(l10n: l10n),
    );
  }
}
