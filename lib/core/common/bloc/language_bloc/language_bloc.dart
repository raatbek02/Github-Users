
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_event.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
//   LanguageBloc() : super(const LanguageState(Locale('en'))) {
//     on<ChangeLanguage>((event, emit) {
//       emit(LanguageState(event.locale));
//     });
//   }
// }

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<ChangeLanguage>(_onChangeLanguage);
    _loadPreferredLanguage();
  }

  Future<void> _loadPreferredLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    add(ChangeLanguage(Locale(languageCode)));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    emit(LanguageState(event.locale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', event.locale.languageCode);
  }
}
