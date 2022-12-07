
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';

class ThemeBloc extends ChangeNotifier{
  bool? _darkTheme;


  bool? get darkTheme => _darkTheme;


  ThemeBloc() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme(){
    _darkTheme = !_darkTheme!;
    _saveToPrefs();
    notifyListeners();
  }
  _loadFromPrefs() async {

    _darkTheme = await getIt<SharedPreferenceHelper>().getTheme() ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await getIt<SharedPreferenceHelper>().saveTheme(_darkTheme!);
  }

}