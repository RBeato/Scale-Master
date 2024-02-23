import 'package:flutter_riverpod/flutter_riverpod.dart';

final beatCounterProvider = StateProvider<int>((ref) => 0);

final currentBeatProvider = StateProvider.autoDispose<int>((ref) => 0);
