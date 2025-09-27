import 'package:w2d_customer_mobile/core/config/my_shared_pref.dart';

abstract class LocalDatasource {
  String? getAccessToken();

  setAccessToken(String token);

  String? getRefreshToken();

  setRefreshToken(String token);

  String? getUserName();

  setUserName(String name);

  String? getUserEmail();

  setUserEmail(String email);

  String? getCartId();

  setCartId(String cartId);

  String? getUniqueId();

  setUniqueId(String uniqueId);

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

  setBrandMall(bool isBrandMall);

  bool? getBrandMall();

  String? getStoreID();

  setStoreID(String storeID);

  String? getStoreAuthKey();

  setStoreAuthKey(String authKey);

  clearToken();

  logout();
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
  String? getUserName() {
    return mySharedPref.getUserName();
  }

  @override
  setUserName(String name) {
    mySharedPref.saveUserName(name);
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
  String? getUniqueId() {
    return mySharedPref.getUniqueId();
  }

  @override
  setUniqueId(String uniqueId) {
    mySharedPref.saveUniqueId(uniqueId);
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

  @override
  bool? getBrandMall() {
    return mySharedPref.getBrandMall();
  }

  @override
  setBrandMall(bool isBrandMall) {
    mySharedPref.setBrandMall(isBrandMall);
  }

  @override
  clearToken() {
    mySharedPref.saveAccessToken("");
    mySharedPref.saveRefreshToken("");
  }

  @override
  logout() {
    mySharedPref.logout();
  }

  @override
  String? getStoreAuthKey() {
    return mySharedPref.getStoreAuthKey();
  }

  @override
  setStoreAuthKey(String authKey) {
    mySharedPref.saveStoreAuthKey(authKey);
  }

  @override
  String? getStoreID() {
    return mySharedPref.getStoreID();
  }

  @override
  setStoreID(String storeId) {
    mySharedPref.saveStoreID(storeId);
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
