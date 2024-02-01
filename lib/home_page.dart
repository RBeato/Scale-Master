import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/chromatic_wheel/chromatic_wheel.dart';

import 'UI/drawer/UI/custom_drawer.dart';
import 'UI/fretboard/UI/fretboard_neck.dart';
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
            // const Expanded(flex: 2, child: Chords()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                    tooltip: 'Play',
                    color: Colors.orange[800],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   backgroundColor: Colors.orange[800],
      //   child: const Icon(Icons.play_arrow),
      // ),
    );
  }
}
