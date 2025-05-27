// ignore_for_file: constant_identifier_names

class EndPoints {
  /// Customer Endpoints
  static const String createCustomer = '/customer/create/';
  static const String sendOtp = '/customer/send-otp';
  static const String verifyOtp = '/customer/verify-otp/';
  static const String tokenRefresh = '/customer/token/refresh/';

  /// Categories Endpoints
  static const String categories = '/categories/';
  static const String categoriesHierarchy = '/categories/hierarchy/';

  /// Collections Endpoints
  static const String collectionsGetByName = '/collections/get-by-name/';

  /// Product Endpoints
  static const String productView = '/product/view';

  /// Cart Sync Endpoint
  static const String cartSync = '/cart-sync/';

  /// Cart Endpoints
  static const String cart = '/cart/';
  static const String cartUpdate = '/cart/update/';

  /// Shipping Endpoints
  static const String getFreightQuote = '/get-freight-quote';
  static const String selectFreightService = '/select-freight-service';
  static const String calculateInsurance = '/calculate-insurance';
  static const String confirmInsurance = '/confirm-insurance';
  static const String addJob = '/confirm-job';
}
