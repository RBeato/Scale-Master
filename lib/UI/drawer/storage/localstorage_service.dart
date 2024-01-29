import 'package:shared_preferences/shared_preferences.dart';
import '../../../hardcoded_data/guitar_chord_voicings.dart';
import '../../../models/settings_model.dart';
import '../helper/chord_settings_filter.dart';

class LocalStorageService {
  late bool darkHarmony;
  late double musicKey;
  late bool scaleAndChordsOption;
  late String originScaleType;
  late String chordVoicingOption;
  late List<dynamic> bottomNoteStringList;
  late String bottomNoteStringOption;
  late String keyboardSound;
  late String bassSound;
  late bool bassIsSelected;
  late String drumsSound;
  late bool drumsIsSelected;
  late bool showOnboarding;

  late Settings settings;

  final String _musicKeyKey = 'musicKey';
  final String _scalesAndChordsKey = 'scalesAndChords';
  final String _originScaleTypeKey = 'scaleChoosen';
  final String _chordVoicingsKey = 'chordVoicings';
  final String _bottomNoteStringOptionKey = 'lowestNoteString';
  final String _bottomNoteStringListKey = 'lowestNoteListString';

  Future<Settings> fetchSettings() async {
    musicKey = await _getFromDisk(_musicKeyKey) ?? 0.0;
    originScaleType =
        await _getFromDisk(_originScaleTypeKey) ?? 'Diatonic Major';
    scaleAndChordsOption = await _getFromDisk(_scalesAndChordsKey) ?? false;
    bottomNoteStringList = await _getFromDisk(_bottomNoteStringListKey) ??
        GuitarChordVoicings.allChordTonesBottomStrings;
    chordVoicingOption = 'All chord tones';
    bottomNoteStringOption = createBottomStringList(chordVoicingOption).first;

    settings = Settings(
      bottomNoteStringList: bottomNoteStringList,
      bottomNoteStringOption: bottomNoteStringOption,
      chordVoicingOption: chordVoicingOption,
      chordVoicings: GuitarChordVoicings.chordVoicings,
      musicKey: musicKey,
      originScale: originScaleType,
      scaleAndChordsOption: scaleAndChordsOption,
    );
    return settings;
  }

  Future<Settings> changeSettings(title, value) async {
    late String key;
    if (title == 'Music Key') {
      settings.musicKey = value;
      key = _musicKeyKey;
    }
    if (title == 'Scales + Chords') {
      settings.scaleAndChordsOption = value;
      key = _scalesAndChordsKey;
    }

    if (title == 'Chord Voicings') {
      settings.chordVoicingOption = value;
      key = _chordVoicingsKey;
      try {
        settings.bottomNoteStringList = createBottomStringList(value);
        _saveToDisk(_bottomNoteStringListKey, settings.bottomNoteStringList);
        settings.bottomNoteStringOption = settings.bottomNoteStringList.first;
        _saveToDisk(
            _bottomNoteStringOptionKey, settings.bottomNoteStringOption);
      } catch (e) {
        print("Couldn't get Bottom note string data");
      }
    }
    if (title == 'Bottom Note String') {
      settings.bottomNoteStringOption = value;
      key = _bottomNoteStringOptionKey;
    }
    _saveToDisk(key, value);
    // print('Local Storage changeSettings() $settings');
    return settings;
  }

  Future<Settings> getFiltered(title) {
    Object? value;
    if (title == 'Music Key') {
      value = settings.musicKey;
    }
    if (title == 'Chord Voicings') {
      value = settings.chordVoicingOption;
    }
    if (title == 'Bottom Note String') {
      value = settings.bottomNoteStringOption;
    }
    print('LocalStorageService getFiltered() $settings');
    return value as Future<Settings>;
  }

  Future<dynamic> _getFromDisk(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.get(key);
    // print('LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print('LocalStorageService:_saveStringToDisk. key: $key value: $content');
    if (content is String) {
      preferences.setString(key, content);
    }
    if (content is bool) {
      preferences.setBool(key, content);
    }
    if (content is int) {
      preferences.setInt(key, content);
    }
    if (content is double) {
      preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      preferences.setStringList(key, content);
    }
  }

  clearPreferences() async {
    settings = Settings(
      musicKey: 0.0,
      scaleAndChordsOption: false,
      originScale: 'Diatonic Major',
      chordVoicingOption: 'All chord tones',
      chordVoicings: GuitarChordVoicings.chordVoicings,
      bottomNoteStringList: GuitarChordVoicings.allChordTonesBottomStrings,
      bottomNoteStringOption:
          GuitarChordVoicings.allChordTonesBottomStrings.first,
    );
    _saveToDisk(_musicKeyKey, 0.0);
    _saveToDisk(_scalesAndChordsKey, false);
    _saveToDisk(_originScaleTypeKey, "Diatonic Major");
    _saveToDisk(_chordVoicingsKey, GuitarChordVoicings.chordVoicings.first);
    _saveToDisk(_bottomNoteStringOptionKey,
        GuitarChordVoicings.allChordTonesBottomStrings.first);
    _saveToDisk(_bottomNoteStringListKey,
        GuitarChordVoicings.allChordTonesBottomStrings);

    return settings;
  }
}
