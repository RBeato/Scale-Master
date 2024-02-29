import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';

import 'UI/drawer/UI/custom_drawer.dart';
import 'UI/piano/piano_widget.dart';
import 'UI/player_page/player_page.dart';
import 'UI/scale_selection_dropdowns/scale_selection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PlayerPage()));
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 2, child: ScaleSelector()),
            Expanded(flex: 10, child: Center(child: ChromaticWheel())),
            const Expanded(flex: 10, child: PianoWidget()),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
