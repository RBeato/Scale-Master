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
    if (settingsSelection == SettingsSelection.isTonicUniversalBassNote) {
      value = settings.isTonicUniversalBassNote;
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
    bool isTonicUniversalBassNote = preferences
            .getBool(SettingsSelection.isTonicUniversalBassNote.toString()) ??
        false;
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
      isTonicUniversalBassNote: isTonicUniversalBassNote,
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
    preferences.setBool(SettingsSelection.singleColor.toString(),
        settings.isTonicUniversalBassNote);
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
    } else if (settingsSelection ==
        SettingsSelection.isTonicUniversalBassNote) {
      settings.isTonicUniversalBassNote = value;
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
      isTonicUniversalBassNote: false,
      keyboardSound: 'Piano',
      bassSound: 'Double Bass',
      drumsSound: 'Acoustic',
    );

    await _saveSettingsToDisk(settings);

    return settings;
  }
}
