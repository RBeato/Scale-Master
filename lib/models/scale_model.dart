import 'package:scale_master_guitar/models/settings_model.dart';
import 'package:tonic/tonic.dart';

class ScaleModel {
  String parentScaleKey = 'C';
  String? scale;
  String? mode;
  List<String> scaleNotesNames = [];
  List<String> chordTypes = [];
  List<String> degreeFunction = [];
  List<List<Interval>> modesScalarTonicIntervals = [];
  String? originModeType;
  Settings? settings;

  ScaleModel({
    this.parentScaleKey = 'C',
    required this.scale,
    required this.mode,
    required this.scaleNotesNames,
    required this.chordTypes,
    required this.degreeFunction,
    required this.originModeType,
    required this.modesScalarTonicIntervals,
    this.settings,
  });

  // Copy method for immutability
  ScaleModel copyWith({
    String? parentScaleKey,
    String? scale,
    String? mode,
    List<String>? scaleNotesNames,
    List<String>? chordTypes,
    List<String>? degreeFunction,
    List<List<Interval>>? modesIntervals,
    String? originModeType,
    Settings? settings,
  }) {
    return ScaleModel(
      parentScaleKey: parentScaleKey ?? this.parentScaleKey,
      scale: scale ?? this.scale,
      mode: mode ?? this.mode,
      modesScalarTonicIntervals: modesIntervals ?? modesScalarTonicIntervals,
      scaleNotesNames: scaleNotesNames ?? this.scaleNotesNames,
      chordTypes: chordTypes ?? this.chordTypes,
      degreeFunction: degreeFunction ?? this.degreeFunction,
      originModeType: originModeType ?? this.originModeType,
      settings: settings ?? this.settings,
    );
  }

  @override
  String toString() {
    return '''ScaleModel(parentScaleKey: $parentScaleKey\n, scale: $scale\n, mode: $mode\n, originModeType: $originModeType\n
     scaleNotesNames: $scaleNotesNames\n, chordTypes: $chordTypes\n, degreeFunction: $degreeFunction\n, settings: $settings)''';
  }
}

class Nullable<T> {
  final T? _value; // Make the value nullable
  Nullable(this._value);
  T? get value {
    return _value;
  }
}
