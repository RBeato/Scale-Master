import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../provider/settings_state_notifier.dart';

class DrawerCard extends ConsumerWidget {
  String title;
  String subtitle;
  String savedValue;
  List dropdownList;

  DrawerCard(
      {required this.title,
      required this.subtitle,
      required this.dropdownList,
      required this.savedValue});

  late String _selection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.black12,
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),

        // subtitle: Text(subtitle, style: const TextStyle(fontSize: 11.0)),
        trailing: DropdownButton<String>(
            // dropdownColor: drawerDropdownColor,
            value: _selection = savedValue,
            style: const TextStyle(fontSize: 14.0),
            icon: const Icon(Icons.arrow_downward),
            iconSize: 15,
            elevation: 10,
            disabledHint: const Text('Disabled'),
            underline:
                Container(height: 2, color: Colors.white.withOpacity(0.5)),
            onChanged: (String? newValue) {
              _selection = newValue as String;
              ref
                  .read(settingsStateNotifierProvider.notifier)
                  .changeValue(title, _selection);
            },
            items: dropdownList.map((item) {
              return DropdownMenuItem(
                value: item.toString(),
                child: Text(item,
                    style:
                        const TextStyle(fontSize: 14.0, color: Colors.white)),
              );
            }).toList() // ?? [],
            ),
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                subtitle,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    );

    // Card(
    //   // color: drawerSetsColor,
    //   child: ListTile(
    //     title: Text(
    //       title,
    //     ),
    //     subtitle: Text(subtitle, style: const TextStyle(fontSize: 11.0)),
    //     trailing: DropdownButton<String>(
    //         dropdownColor: drawerDropdownColor,
    //         value: _selection = savedValue,
    //         style: const TextStyle(fontSize: 14.0),
    //         icon: const Icon(Icons.arrow_downward),
    //         iconSize: 15,
    //         elevation: 10,
    //         disabledHint: const Text('Disabled'),
    //         underline:
    //             Container(height: 2, color: Colors.white.withOpacity(0.5)),
    //         onChanged: (String? newValue) {
    //           _selection = newValue as String;
    //           ref
    //               .read(settingsStateNotifierProvider.notifier)
    //               .changeValue(title, _selection);
    //         },
    //         items: dropdownList.map((item) {
    //           return DropdownMenuItem(
    //             value: item.toString(),
    //             child: Text(item),
    //           );
    //         }).toList() // ?? [],
    //         ),
    //   ),
    // );
  }
}
