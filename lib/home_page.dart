import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';

import 'UI/drawer/UI/custom_drawer.dart';
import 'UI/fretboard/UI/fretboard_neck.dart';
import 'UI/player_page/player_page.dart';
import 'UI/scale_selection/scale_selection.dart';

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
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(flex: 2, child: ScaleSelector()),
            Expanded(flex: 10, child: Center(child: ChromaticWheel())),
            Expanded(
                flex: 6,
                child: Center(
                  child: Fretboard(),
                )),
            // const PianoWidget(),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PlayerPage()));
        },
        tooltip: 'play',
        backgroundColor: Colors.orange[800],
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
