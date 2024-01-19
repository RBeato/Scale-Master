import 'package:scale_master_guitar/models/chord_model.dart';

class TrashChordModel {
  bool isBassNote;
  int positionIndex;
  ChordModel chordModel;

  TrashChordModel(
      {required this.isBassNote,
      required this.positionIndex,
      required this.chordModel});

  @override
  String toString() {
    return "isBass: $isBassNote, Position:$positionIndex, chordModel: $chordModel";
  }
}
