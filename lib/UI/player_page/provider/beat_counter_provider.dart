import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeatCounter extends StateNotifier<int> {
  BeatCounter() : super(8);

  Orientation orientation = Orientation.portrait;

  setInitialBeatNumber(Orientation orientation) {
    late int initialValue;
    if (orientation == Orientation.landscape) initialValue = 10;
    if (orientation == Orientation.portrait) initialValue = 8;
    state = initialValue;
  }

  void increment() {
    orientation = orientation;
    if (state < getMaxValue()) {
      state++;
    } else {
      return;
    }
  }

  void decrement() {
    if (state > 1) {
      state--;
    } else {
      return;
    }
  }

  getMaxValue() {
    late int maxValue;
    if (orientation == Orientation.landscape) maxValue = 20;
    if (orientation == Orientation.portrait) maxValue = 16;
    return maxValue;
  }

  setNumberOfBeats(int numberOfBeats) {
    state = numberOfBeats;
  }
}

final beatCounterProvider = StateNotifierProvider((ref) => BeatCounter());

final currentBeatProvider = StateProvider.autoDispose<int>((ref) => 0);
