import 'package:flutter/material.dart';

class InfoAboutChordsIcon extends StatefulWidget {
  const InfoAboutChordsIcon({super.key});

  @override
  State<InfoAboutChordsIcon> createState() => _InfoAboutChordsIconState();
}

class _InfoAboutChordsIconState extends State<InfoAboutChordsIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Chord Selection'),
              content: const Text(
                  'Tap once to select a chord with the duration of 2 beats, tap twice to select a chord with the duration of 4 beats.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.info_outline,
          color: Colors.orange,
        ),
      ),
    );
  }
}