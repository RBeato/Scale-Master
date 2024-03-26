import 'package:scale_master_guitar/UI/drawer/UI/drawer/settings_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/settings_model.dart';

class LocalStorageService {
  late Settings settings;

  LocalStorageService() {
    fetchSettings();
  }
  Future<Settings> fetchSettings() async {
    settings = await _loadSettingsFromDisk();
    return settings;
  }

  Future<Settings> changeSettings(
      SettingsSelection settingsSelection, value) async {
    _updateSettings(settingsSelection, value);
    await _saveSettingsToDisk(settings);
    return settings;
  }

  Future<Settings> getFiltered(settingsSelection) async {
    // Initialize a variable to hold the value corresponding to the selection
    dynamic value;

    // Determine which setting is being requested and assign its value to 'value'
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

    // Debugging statement to print the settings object
    print('LocalStorageService getFiltered() $settings');

    // Return the settings object after filtering based on the selection
    return settings;
  }

  Future<Settings> _loadSettingsFromDisk() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool showScaleDegrees =
        preferences.getBool(SettingsSelection.scaleDegrees.toString()) ?? false;
    bool isSingleColor =
        preferences.getBool(SettingsSelection.singleColor.toString()) ?? false;
    String keyboardSound =
        preferences.getString(SettingsSelection.keyboardSound.toString()) ??
            'Piano';
    String bassSound =
        preferences.getString(SettingsSelection.bassSound.toString()) ??
            'Electric';
    String drumsSound =
        preferences.getString(SettingsSelection.drumsSound.toString()) ??
            'Acoustic';

    Settings settings = Settings(
      showScaleDegrees: showScaleDegrees,
      isSingleColor: isSingleColor,
      keyboardSound: keyboardSound,
      bassSound: bassSound,
      drumsSound: drumsSound,
    );

    return settings;
  }

  Future<void> _saveSettingsToDisk(Settings settings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(
        SettingsSelection.scaleDegrees.toString(), settings.showScaleDegrees);
    preferences.setBool(
        SettingsSelection.singleColor.toString(), settings.isSingleColor);
    preferences.setString(
        SettingsSelection.keyboardSound.toString(), settings.keyboardSound);
    preferences.setString(
        SettingsSelection.bassSound.toString(), settings.bassSound);
    preferences.setString(
        SettingsSelection.drumsSound.toString(), settings.drumsSound);
  }

  void _updateSettings(SettingsSelection settingsSelection, value) {
    // Update the settings object based on the selection and value
    if (settingsSelection == SettingsSelection.scaleDegrees) {
      settings.showScaleDegrees = value;
    } else if (settingsSelection == SettingsSelection.singleColor) {
      settings.isSingleColor = value;
    } else if (settingsSelection == SettingsSelection.keyboardSound) {
      settings.keyboardSound = value;
    } else if (settingsSelection == SettingsSelection.bassSound) {
      settings.bassSound = value;
    } else if (settingsSelection == SettingsSelection.drumsSound) {
      settings.drumsSound = value;
    }
  }

  Future<Settings> clearPreferences() async {
    settings = Settings(
      showScaleDegrees: false,
      isSingleColor: false,
      keyboardSound: 'Piano',
      bassSound: 'Double Bass',
      drumsSound: 'Acoustic',
    );

    await _saveSettingsToDisk(settings);

    return settings;
  }

  ////////////////////

  // Future<Settings> fetchSettings() async {
  //   settings = Settings(
  //     showScaleDegrees:
  //         await _getFromDisk(SettingsSelection.scaleDegrees.toString()) ??
  //             false,
  //     isSingleColor:
  //         await _getFromDisk(SettingsSelection.singleColor.toString()) ?? false,
  //     keyboardSound:
  //         await _getFromDisk(SettingsSelection.keyboardSound.toString()) ??
  //             'Piano',
  //     bassSound: await _getFromDisk(SettingsSelection.bassSound.toString()) ??
  //         'Electric',
  //     drumsSound: await _getFromDisk(SettingsSelection.drumsSound.toString()) ??
  //         'Acoustic',
  //   );
  //   return settings;
  // }

  // Future<Settings> changeSettings(settingsSelection, value) async {
  //   late String key;

  //   if (settingsSelection == SettingsSelection.scaleDegrees) {
  //     settings.showScaleDegrees = value;
  //   }
  //   if (settingsSelection == SettingsSelection.singleColor) {
  //     settings.isSingleColor = value;
  //   }
  //   if (settingsSelection == SettingsSelection.keyboardSound) {
  //     settings.keyboardSound = value;
  //   }
  //   if (settingsSelection == SettingsSelection.bassSound) {
  //     settings.bassSound = value;
  //   }
  //   if (settingsSelection == SettingsSelection.drumsSound) {
  //     settings.drumsSound = value;
  //   }

  //   key = settingsSelection.toString();
  //   _saveToDisk(key, value);
  //   return settings;
  // }

  // Future<Settings> getFiltered(settingsSelection) {
  //   Object? value;

  //   if (settingsSelection == SettingsSelection.bassSound) {
  //     value = settings.bassSound;
  //   }
  //   if (settingsSelection == SettingsSelection.drumsSound) {
  //     value = settings.drumsSound;
  //   }
  //   if (settingsSelection == SettingsSelection.keyboardSound) {
  //     value = settings.keyboardSound;
  //   }
  //   if (settingsSelection == SettingsSelection.scaleDegrees) {
  //     value = settings.showScaleDegrees;
  //   }
  //   if (settingsSelection == SettingsSelection.singleColor) {
  //     value = settings.isSingleColor;
  //   }

  //   print('LocalStorageService getFiltered() $settings');
  //   return value as Future<Settings>;
  // }

  // Future<dynamic> _getFromDisk(String key) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var value = preferences.get(key);
  //   // print('LocalStorageService:_getFromDisk. key: $key value: $value');
  //   return value;
  // }

  // void _saveToDisk<T>(String key, T content) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // print('LocalStorageService:_saveStringToDisk. key: $key value: $content');
  //   if (content is String) {
  //     preferences.setString(key, content);
  //   }
  //   if (content is bool) {
  //     preferences.setBool(key, content);
  //   }
  //   if (content is int) {
  //     preferences.setInt(key, content);
  //   }
  //   if (content is double) {
  //     preferences.setDouble(key, content);
  //   }
  //   if (content is List<String>) {
  //     preferences.setStringList(key, content);
  //   }
  // }

  // clearPreferences() async {
  //   settings = Settings(
  //     showScaleDegrees: false,
  //     isSingleColor: false,
  //     keyboardSound: 'Piano',
  //     bassSound: 'Double Bass',
  //     drumsSound: 'Acoustic',
  //   );
  //   _saveToDisk(SettingsSelection.scaleDegrees.toString(), false);
  //   _saveToDisk(SettingsSelection.singleColor.toString(), false);
  //   _saveToDisk(SettingsSelection.keyboardSound.toString(), 'Piano');
  //   _saveToDisk(SettingsSelection.bassSound.toString(), 'Double Bass');
  //   _saveToDisk(SettingsSelection.drumsSound.toString(), 'Acoustic');

  //   return settings;
  // }
}
