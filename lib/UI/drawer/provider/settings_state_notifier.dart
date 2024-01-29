import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scale_master_guitar/UI/drawer/models/settings_state.dart';

import '../../../models/settings_model.dart';
import '../storage/localstorage_service.dart';

final settingsProvider = FutureProvider<Settings>((ref) async {
  return await ref.watch(settingsStateNotifierProvider.notifier).settings;
});

final settingsStateNotifierProvider =
    StateNotifierProvider<SettingsStateNotifier, SettingsState>((ref) {
  return SettingsStateNotifier();
});

class SettingsStateNotifier extends StateNotifier<SettingsState> {
  SettingsStateNotifier() : super(SettingsInitial()) {
    getSettings();
  }

  final LocalStorageService localStorageProvider = LocalStorageService();

  get settings => localStorageProvider.fetchSettings();

  Future getSettings() async {
    state = SettingsLoading();
    try {
      final settings = await localStorageProvider.fetchSettings();
      state = SettingsLoaded(settings);
      return state;
    } catch (e) {
      state = SettingsError("Couldn't FETCH settings!");
    }
  }

  Future<void> changeValue(title, value) async {
    try {
      final settings = await localStorageProvider.changeSettings(title, value);
      state = SettingsLoaded(settings);
    } catch (e) {
      state = SettingsError("Couldn't CHANGE the settings!");
    }
  }

  Future getFilteredValue(title) async {
    try {
      final settings = await localStorageProvider.getFiltered(title);
      return settings;
    } catch (e) {
      // print("Didn't get filtered Value");
    }
  }

  Future<void> resetValues() async {
    try {
      final settings = await localStorageProvider.clearPreferences();
      state = SettingsLoaded(settings);
    } catch (e) {
      state = SettingsError("Couldn't RESET the settings!");
    }
  }
}
