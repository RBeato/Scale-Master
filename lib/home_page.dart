import 'package:flutter/material.dart';
import 'package:scale_master_guitar/UI/scale_chart/chromatic_wheel.dart';

import 'UI/drawer/UI/custom_drawer.dart';
import 'UI/fretboard/UI/fretboard_card.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleSelector(),
            ChromaticWheel(),
            const FretboardCard(),
            // const PianoWidget(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Colors.orange[800],
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
