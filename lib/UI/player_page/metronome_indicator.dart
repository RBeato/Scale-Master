import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../fretboard/provider/beat_counter_provider.dart';

class MetronomeIndicator extends ConsumerWidget {
  const MetronomeIndicator({required this.currentStep, required this.isBass});
  final int currentStep;
  final bool isBass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
          height: 30,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  enableFeedback: false,
                  child: Container(
                    width: 30,
                  ),
                ),
                Expanded(child: Consumer(builder: (context, watch, _) {
                  final numberBeats = ref.watch(beatCounterProvider) as int;
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                        width: 1.0,
                        color: Colors.transparent,
                      )),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List<Widget>.generate(
                        numberBeats,
                        (i) => Expanded(
                          child: SizedBox.expand(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _getColor(i, currentStep),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })),
              ])),
    );
  }

  Color _getColor(int i, int currentStep) {
    Color color = Colors.white;
    if (i == currentStep) {
      color = Colors.white70.withOpacity(0.2);
    } else {
      color = Colors.transparent;
    }
    return color;
  }
}
