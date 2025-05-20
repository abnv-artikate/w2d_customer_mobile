import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
  static const userEmail = "user_email";
  static const cartID = "cart_id";
  static const latitudeKey = "latitude";
  static const longitudeKey = "longitude";

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

  void saveUserEmail(String email) {
    _pref.setString(userEmail, email);
  }

  String? getUserEmail() {
    return _pref.getString(userEmail);
  }

  void saveCartId(String cartId) {
    _pref.setString(cartID, cartId);
  }

  String? getCartId() {
    return _pref.getString(cartID);
  }

  void saveLatitude(double latitude) {
    _pref.setDouble(latitudeKey, latitude);
  }

  double? getLatitude() {
    return _pref.getDouble(latitudeKey);
  }

  void saveLongitude(double longitude) {
    _pref.setDouble(longitudeKey, longitude);
  }

  double? getLongitude() {
    return _pref.getDouble(longitudeKey);
  }

  void logout() {
    _pref.remove(accessToken);
  }
}
