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
  static const String collections = '/admin/collections/';

  /// Product Endpoints
  static const String productView = '/product/view';

  /// Cart Sync Endpoint
  static const String cartSync = '/cart-sync/';

  /// Cart Endpoints
  static const String cart = '/cart/';
  static const String cartUpdate = '/cart/update/';

  /// Search Endpoint
  static const String searchAutoComplete = '/products/search/autocomplete/';

  /// Shipping Endpoints
  static const String getFreightQuote = '/get-freight-quote';
  static const String selectFreightService = '/select-freight-service';
  static const String calculateInsurance = '/calculate-insurance';
  static const String confirmInsurance = '/confirm-insurance';
  static const String addJob = '/confirm-job';

  /// Telr Payment Endpoints
  static const String createPayment = 'mobile.xml';
  static const String confirmPayment = 'mobile_complete.xml';

  /// Address Endpoits
  static const String customerAddress = '/customer/address/';
  static const String customerAddresses = '/customer/addresses/';

  /// Order Endpoints
  static const String createOrder = '/order/create/';
  static const String orderPending = '/order/pending-mobile/';
  static const String orderSuccess = '/order/success/';

  /// Orders Endpoint
  static const String orders = '/orders/';

  /// Wishlist Endpoint
  static const String wishlist = '/wishlist/';

  /// Recommendation Endpoint
  static const String recommendations = '/recommendations/';

  /// Related Endpoint
  static const String related = '/related/';

  /// Browsing History Endpoints
  static const String browsingHistory = '/browsing-history/';
  static const String browsingHistoryAdd = '/browsing-history/add/';
}
