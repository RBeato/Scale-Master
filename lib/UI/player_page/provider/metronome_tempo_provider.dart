import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetronomeTempo extends StateNotifier<double> {
  MetronomeTempo() : super(120);

  void changeTempo(double tempo) {
    state = tempo;
  }
}

final metronomeTempoProvider = StateNotifierProvider((ref) => MetronomeTempo());
