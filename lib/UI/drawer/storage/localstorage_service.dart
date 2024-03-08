import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/settings_model.dart';

class LocalStorageService {
  late double musicKey;
  late bool scaleAndChordsOption;
  late String keyboardSound;
  late String bassSound;
  late bool bassIsSelected;
  late String drumsSound;
  late bool drumsIsSelected;

  late Settings settings;

  final String _musicKeyKey = 'musicKey';

  final String _originScaleTypeKey = 'scaleChosen';

  Future<Settings> fetchSettings() async {
    musicKey = await _getFromDisk(_musicKeyKey) ?? 0.0;

    settings = Settings(
      musicKey: musicKey,
    );
    return settings;
  }

  Future<Settings> changeSettings(title, value) async {
    late String key;
    if (title == 'Music Key') {
      settings.musicKey = value;
      key = _musicKeyKey;
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
    );
    _saveToDisk(_musicKeyKey, 0.0);

    _saveToDisk(_originScaleTypeKey, "Diatonic Major");

    return settings;
  }
}
