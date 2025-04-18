import 'package:w2d_customer_mobile/core/config/my_shared_pref.dart';

abstract class LocalDatasource {
  String? getAccessToken();

  setAccessToken(String token);

  String? getRefreshToken();

  setRefreshToken(String token);
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
}
