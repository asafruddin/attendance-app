import 'package:attendance_app/core/constant/key_constant.dart';
import 'package:attendance_app/data/response/location_list_model.dart';
import 'package:attendance_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({Key? key}) : super(key: key);

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final box = Hive.box<LocationListModel>(KeyConstant.keyLocationBox);

  @override
  void initState() {
    super.initState();

    box.put(
        KeyConstant.keyLocationBox,
        const LocationListModel(locationList: [
          LocationDataModel(
              latitude: '7.7120549',
              longitude: '110.0086309',
              locationName: 'Purworejo, Jawa Tengah')
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final location = box.get(KeyConstant.keyLocationBox);

    return Scaffold(
        appBar: AppBar(title: Text(l10n.locationListAppBarTitle)),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            onPressed: () {},
            child: const Icon(Icons.add)),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                trailing: const Icon(Icons.chevron_right_rounded),
                title: Text(location?.locationList?[index].locationName ?? ''),
                onTap: () {},
              );
            },
            separatorBuilder: (_, i) => const SizedBox(),
            itemCount: location?.locationList?.length ?? 0));
  }
}
