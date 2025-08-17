import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
  static const userName = "user_name";
  static const userEmail = "user_email";
  static const cartID = "cart_id";
  static const latitudeKey = "latitude";
  static const longitudeKey = "longitude";
  static const destinationCity = "destination_city";
  static const destinationCountry = "destination_country";
  static const brandMall = "brand_mall";

  final SharedPreferences _pref;

  MySharedPref(this._pref);

  void saveAccessToken(String token) async {
    await _pref.setString(accessToken, token);
  }

  String? getAccessToken() {
    return _pref.getString(accessToken);
  }

  void saveRefreshToken(String token) async {
    await _pref.setString(refreshToken, token);
  }

  String? getRefreshToken() {
    return _pref.getString(refreshToken);
  }

  void saveUserName(String name) async {
    await _pref.setString(userName, name);
  }

  String? getUserName() {
    return _pref.getString(userName);
  }

  void saveUserEmail(String email) async {
    await _pref.setString(userEmail, email);
  }

  String? getUserEmail() {
    return _pref.getString(userEmail);
  }

  void saveCartId(String cartId) async {
    await _pref.setString(cartID, cartId);
  }

  String? getCartId() {
    return _pref.getString(cartID);
  }

  void saveLatitude(double latitude) async {
    await _pref.setDouble(latitudeKey, latitude);
  }

  double? getLatitude() {
    return _pref.getDouble(latitudeKey);
  }

  void saveLongitude(double longitude) async {
    await _pref.setDouble(longitudeKey, longitude);
  }

  double? getLongitude() {
    return _pref.getDouble(longitudeKey);
  }

  void saveDestinationCity(String city) async {
    await _pref.setString(destinationCity, city);
  }

  String? getDestinationCity() {
    return _pref.getString(destinationCity);
  }

  void saveDestinationCountry(String country) async {
    await _pref.setString(destinationCountry, country);
  }

  String? getDestinationCountry() {
    return _pref.getString(destinationCountry);
  }

  void setBrandMall(bool isBrandMall) async {
    await _pref.setBool(brandMall, isBrandMall);
  }

  bool? getBrandMall() {
    return _pref.getBool(brandMall);
  }

  void logout() {
    _pref.remove(accessToken);
    _pref.remove(refreshToken);
    _pref.remove(userName);
    _pref.remove(userEmail);
    _pref.remove(cartID);
  }
}
