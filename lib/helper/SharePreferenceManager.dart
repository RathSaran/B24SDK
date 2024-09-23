import 'package:sample_merchant_app_flutter/const/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceManager {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance(); 
  }

  SharedPreferences get prefs => _prefs;
}
