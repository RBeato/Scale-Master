import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MetronomeDisplay extends StatelessWidget {
  const MetronomeDisplay({
    required this.selectedTempo,
    required this.handleChange,
  });

  final double selectedTempo;
  final Function(double nextTempo) handleChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.black26,
        // border: Border.all(color: Colors.orange.withOpacity(0.32)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 40,
        width: 40,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () => showDialog(
              context: context,
              builder: (_) => BPMSelector(
                  selectedTempo: selectedTempo, handleChange: handleChange)),
          child: Text(
            selectedTempo.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class BPMSelector extends StatelessWidget {
  BPMSelector({
    required this.selectedTempo,
    required this.handleChange,
  });

  final double selectedTempo;
  final Function(double nextTempo) handleChange;

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    int itemHeight = ((selectedTempo / 2.55) - 10)
        .round(); //empirical value for 'remembering' bpm value when opening dialog
    double listHeight = 256.toDouble() * itemHeight;
    double offset = (listHeight / selectedTempo * itemHeight);
    // print('itemHeight: ${(selectedTempo / 2).round()}');
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.jumpTo(offset));

    return Dialog(
      backgroundColor: Colors.black38,
      child: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: ListView.builder(
            controller: _controller,
            itemCount: 161, //change metronome values
            itemBuilder: (context, i) => InkWell(
              onTap: () {
                handleChange((i + 40).toDouble());
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 40,
                child: Center(
                  child: AutoSizeText(
                    (i + 40).toString(),
                    minFontSize: 12.0,
                    maxFontSize: 25.0,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 185.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
