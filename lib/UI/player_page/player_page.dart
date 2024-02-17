import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/player_widget.dart';

import '../chords/chords.dart';
import '../fretboard/UI/fretboard_neck.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  Future<bool> popped(BuildContext context) {
    // Handle back button press here if needed
    return Future.value(true);
  }

  // Callback function to handle back button press
  void handleBackButtonPressed() {
    // Handle back button press here
    // For example:
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () => popped(context),
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Play!"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Fretboard(),
              const Expanded(flex: 1, child: Chords()),
              Expanded(
                  flex: 4,
                  child: PlayerWidget(
                    onBackButtonPressed: handleBackButtonPressed,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
