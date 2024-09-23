import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_merchant_app_flutter/screen/directdebit/direct_debit_screen.dart';

class MerchantProvider extends ChangeNotifier {
  bool isBearerToken = false;
  void enableBearerToken(bool value) {
    isBearerToken = value;
    notifyListeners();
  }

  bool isEnglish = false;
  void setEnglish(bool value) {
    isEnglish = value;
    notifyListeners();
  }

  bool isDarkMode = false;
  void setDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  bool isProduction = false;
  void setProduction(bool value) {
    isProduction = value;
    notifyListeners();
  }

  bool settingEnglish = false;
  void setSettingEnglish(bool value) {
    settingEnglish = value;
    notifyListeners();
  }

  bool settingDarkMode = false;
  void setSettingDarkMode(bool value) {
    settingDarkMode = value;
    notifyListeners();
  }

  bool settingProduction = false;
  void setSettingProduction(bool value) {
    settingProduction = value;
    notifyListeners();
  }

  String? selectOption;

  void changeEnvironment(
    String env,
  ) {
    selectOption = env;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
