import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  void saveAccessToken(String token) {
    _pref.setString(accessToken, token);
  }

  String? getAccessToken() {
    return _pref.getString(accessToken);
  }

  void saveRefreshToken(String token) {
    _pref.setString(refreshToken, token);
  }

  String? getRefreshToken() {
    return _pref.getString(refreshToken);
  }

  void logout() {
    _pref.remove(accessToken);
  }
}
