import 'package:w2d_customer_mobile/core/config/my_shared_pref.dart';

abstract class LocalDatasource {
  String? getAccessToken();

  setAccessToken(String token);

  String? getRefreshToken();

  setRefreshToken(String token);

  String? getUserEmail();

  setUserEmail(String email);

  String? getCartId();

  setCartId(String cartId);

  // setLatitude(double latitude);
  //
  // double? getLatitude();
  //
  // setLongitude(double longitude);
  //
  // double? getLongitude();

  setDestinationCity(String city);

  String? getDestinationCity();

  setDestinationCountry(String country);

  String? getDestinationCountry();
}

class LocalDataSourceImpl extends LocalDatasource {
  final MySharedPref mySharedPref;

  LocalDataSourceImpl(this.mySharedPref);

  @override
  String? getAccessToken() {
    return mySharedPref.getAccessToken();
  }

  @override
  setAccessToken(String token) {
    return mySharedPref.saveAccessToken(token);
  }

  @override
  String? getRefreshToken() {
    return mySharedPref.getRefreshToken();
  }

  @override
  setRefreshToken(String token) {
    return mySharedPref.saveRefreshToken(token);
  }

  @override
  String? getUserEmail() {
    return mySharedPref.getUserEmail();
  }

  @override
  setUserEmail(String email) {
    mySharedPref.saveUserEmail(email);
  }

  @override
  String? getCartId() {
    return mySharedPref.getCartId();
  }

  @override
  setCartId(String cartId) {
    mySharedPref.saveCartId(cartId);
  }

  @override
  String? getDestinationCity() {
    return mySharedPref.getDestinationCity();
  }

  @override
  setDestinationCity(String city) {
    mySharedPref.saveDestinationCity(city);
  }

  @override
  String? getDestinationCountry() {
    return mySharedPref.getDestinationCountry();
  }

  @override
  setDestinationCountry(String country) {
    mySharedPref.saveDestinationCountry(country);
  }

  // @override
  // double? getLatitude() {
  //   return mySharedPref.getLatitude();
  // }
  //
  // @override
  // setLatitude(double latitude) {
  //   mySharedPref.saveLatitude(latitude);
  // }
  //
  // @override
  // double? getLongitude() {
  //   return mySharedPref.getLongitude();
  // }
  //
  // @override
  // setLongitude(double longitude) {
  //   mySharedPref.saveLongitude(longitude);
  // }
}
