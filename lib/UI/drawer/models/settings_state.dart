import 'package:equatable/equatable.dart';

import '../../../models/settings_model.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  SettingsInitial();

  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  SettingsLoading();

  @override
  List<Object> get props => [];
}

class SettingsLoaded extends SettingsState {
  final Settings settings;
  SettingsLoaded(this.settings);

  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);

  @override
  List<Object> get props => [message];
}
