import 'package:scale_master_guitar/models/settings_model.dart';

class ScaleModel {
  String parentScaleKey = 'C';
  String? scale;
  String? mode;
  List? chords; // Specify the type for chords as List<String>
  String? originModeType;
  Settings? settings;

  // Constructor to initialize the properties
  ScaleModel({
    this.parentScaleKey = 'C',
    required this.scale,
    required this.mode,
    required this.chords,
    required this.originModeType,
    this.settings,
  });

  @override
  String toString() {
    return 'ScaleModel(parentScaleKey: $parentScaleKey, scale: $scale, mode: $mode, chords: $chords, originModeType: $originModeType)';
  }
}

class Nullable<T> {
  final T? _value; // Make the value nullable
  Nullable(this._value);
  T? get value {
    return _value;
  }
}
