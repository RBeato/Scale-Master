import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/player_page/player_page.dart';

import '../../models/settings_model.dart';
import '../sizing_info.dart';

class BuildFloatingButton extends ConsumerStatefulWidget {
  const BuildFloatingButton(this.settings, this.sizingInfo);

  final Settings settings;
  final SizingInformation sizingInfo;

  @override
  ConsumerState<BuildFloatingButton> createState() =>
      _BuildFloatingButtonState();
}

class _BuildFloatingButtonState extends ConsumerState<BuildFloatingButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      return Opacity(
        opacity: 0.8,
        child: FloatingActionButton(
          elevation: 15.0,
          splashColor: Colors.orange[500],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerPage(widget.settings)));
          },
          backgroundColor: Colors.orangeAccent,
          child: const Icon(
            Icons.music_note,
            color: Colors.white,
            size: 33.0,
          ),
        ),
      );
    });
  }
}
