import 'package:scale_master_guitar/UI/drawer/UI/drawer/settings_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/settings_model.dart';

class LocalStorageService {
  late Settings settings;

  LocalStorageService() {
    fetchSettings();
  }

  Future<Settings> fetchSettings() async {
    settings = Settings(
      showScaleDegrees:
          await _getFromDisk(SettingsSelection.scaleDegrees.toString()) ??
              false,
      isSingleColor:
          await _getFromDisk(SettingsSelection.singleColor.toString()) ?? false,
      keyboardSound:
          await _getFromDisk(SettingsSelection.keyboardSound.toString()) ??
              'Piano',
      bassSound: await _getFromDisk(SettingsSelection.bassSound.toString()) ??
          'Electric',
      drumsSound: await _getFromDisk(SettingsSelection.drumsSound.toString()) ??
          'Acoustic',
    );
    return settings;
  }

  Future<Settings> changeSettings(settingsSelection, value) async {
    late String key;

    if (settingsSelection == SettingsSelection.scaleDegrees) {
      settings.showScaleDegrees = value;
    }
    if (settingsSelection == SettingsSelection.singleColor) {
      settings.isSingleColor = value;
    }
    if (settingsSelection == SettingsSelection.keyboardSound) {
      settings.keyboardSound = value;
    }
    if (settingsSelection == SettingsSelection.bassSound) {
      settings.bassSound = value;
    }
    if (settingsSelection == SettingsSelection.drumsSound) {
      settings.drumsSound = value;
    }

    key = settingsSelection.toString();
    _saveToDisk(key, value);
    return settings;
  }

  Future<Settings> getFiltered(settingsSelection) {
    Object? value;

    if (settingsSelection == SettingsSelection.bassSound) {
      value = settings.bassSound;
    }
    if (settingsSelection == SettingsSelection.drumsSound) {
      value = settings.drumsSound;
    }
    if (settingsSelection == SettingsSelection.keyboardSound) {
      value = settings.keyboardSound;
    }
    if (settingsSelection == SettingsSelection.scaleDegrees) {
      value = settings.showScaleDegrees;
    }
    if (settingsSelection == SettingsSelection.singleColor) {
      value = settings.isSingleColor;
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
      showScaleDegrees: false,
      isSingleColor: false,
      keyboardSound: 'Piano',
      bassSound: 'Double Bass',
      drumsSound: 'Acoustic',
    );
    _saveToDisk(SettingsSelection.scaleDegrees.toString(), false);
    _saveToDisk(SettingsSelection.singleColor.toString(), false);
    _saveToDisk(SettingsSelection.keyboardSound.toString(), 'Piano');
    _saveToDisk(SettingsSelection.bassSound.toString(), 'Double Bass');
    _saveToDisk(SettingsSelection.drumsSound.toString(), 'Acoustic');

    return settings;
  }
}
