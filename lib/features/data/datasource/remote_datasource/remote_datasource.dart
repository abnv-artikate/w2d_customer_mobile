import 'package:dio/dio.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/client/shipping_client.dart';
import 'package:w2d_customer_mobile/features/data/client/telr_payment_client.dart';
import 'package:w2d_customer_mobile/features/data/model/address/get_customer_addresses_model.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/updated_cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/collections_model.dart';
import 'package:w2d_customer_mobile/features/data/model/orders/order_pending_model.dart';
import 'package:w2d_customer_mobile/features/data/model/orders/orders_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/recommendations/recommendations_model.dart';
import 'package:w2d_customer_mobile/features/data/model/related_products/related_products_model.dart';
import 'package:w2d_customer_mobile/features/data/model/search/search_result_autocomplete_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/calculate_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/confirm_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/freight_quote_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/select_freight_service_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';
import 'package:w2d_customer_mobile/features/data/model/telr_payment/telr_confirm_payment_response_model.dart';
import 'package:w2d_customer_mobile/features/data/model/telr_payment/telr_payment_request_model.dart';
import 'package:w2d_customer_mobile/features/data/model/telr_payment/telr_payment_response_model.dart';
import 'package:w2d_customer_mobile/features/data/model/telr_payment/terl_confirm_payment_request_model.dart';
import 'package:w2d_customer_mobile/features/data/model/wishlist/get_wishlist_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';

abstract class RemoteDatasource {
  /// Auth Datasource
  Future<SuccessMessageModel> sendOtp({
    required Map<String, dynamic> queries,
    required Map<String, dynamic> body,
  });

  Future<VerifyOtpModel> verifyOtp(Map<String, dynamic> body);

  /// Categories Datasource
  Future<ProductCategoryListModel> getProductCategoriesList(
    Map<String, dynamic> query,
  );

  Future<CategoriesModel> getCategoriesHierarchyModel();

  Future<CollectionsModel> getCollections();

  /// Product Datasource
  Future<ProductViewModel> getProductView(String id);

  /// Cart Sync Datasource
  Future<SuccessMessageModel> cartSync(Map<String, dynamic> body);

  /// Cart Datasource
  Future<CartModel> getCart(Map<String, dynamic> queries);

  Future<UpdatedCartModel> updateCart(Map<String, dynamic> body);

  /// Search Datasource
  Future<SearchResultAutoCompleteModel> searchProductAutoComplete(
    Map<String, dynamic> queries,
  );

  /// Shipping Datasource
  Future<FreightQuoteModel> getFreightQuote(Map<String, dynamic> body);

  Future<SelectFreightServiceModel> selectFreightService(
    Map<String, dynamic> body,
  );

  Future<CalculateInsuranceModel> calculateInsurance(Map<String, dynamic> body);

  Future<ConfirmInsuranceModel> confirmInsurance(Map<String, dynamic> body);

  /// Telr Payment Datasource
  Future<TelrPaymentResponseModel> initiatePayment(
    PaymentRequestEntity request,
  );

  Future<TelrConfirmPaymentResponseModel> verifyPayment(String transCode);

  /// Address Datasource
  Future saveCustomerAddress(Map<String, dynamic> body);

  Future<CustomerAddressesModel> getCustomerAddresses();

  /// Order Datasource
  Future<OrderPendingModel> orderPending(Map<String, dynamic> body);

  Future orderSuccess(Map<String, dynamic> body);

  /// Orders Datasource
  Future getOrderByID(String id);

  Future<OrderListModel> getOrdersList(Map<String, dynamic> json);

  Future updateOrder({required String id, required Map<String, dynamic> body});

  Future cancelOrder(String id);

  /// Wishlist Datasource
  Future<SuccessMessageModel> addWishlist(Map<String, dynamic> body);

  Future<GetWishListModel> getWishlist();

  Future<SuccessMessageModel> deleteWishlist(String id);

  /// Recommendation Model
  Future<RecommendationsModel> getRecommendations(String productId);

  /// Related Product Model
  Future<RelatedProductsModel> getRelatedProducts(String productId);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final W2DClient w2dClient;
  final ShippingClient shippingClient;
  final TelrPaymentClient telrPaymentClient;

  RemoteDatasourceImpl({
    required this.telrPaymentClient,
    required this.shippingClient,
    required this.w2dClient,
  });

  // void _processDio(err) {
  //   if (err is DioException) {
  //     throw Exception(err.message);
  //   } else {
  //     throw Exception(Constants.errorUnknown);
  //   }
  // }

  @override
  Future<SuccessMessageModel> sendOtp({
    required Map<String, dynamic> queries,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await w2dClient.sendOtp(queries: queries, body: body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtp(Map<String, dynamic> body) async {
    try {
      return await w2dClient.verifyOtp(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CategoriesModel> getCategoriesHierarchyModel() async {
    try {
      return await w2dClient.getCategoryHierarchy();
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CollectionsModel> getCollections() async {
    try {
      return await w2dClient.getCollections();
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ProductCategoryListModel> getProductCategoriesList(
    Map<String, dynamic> query,
  ) async {
    try {
      return await w2dClient.getProductCategoryListing(query);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ProductViewModel> getProductView(String id) async {
    try {
      return await w2dClient.getProductDetail(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> cartSync(Map<String, dynamic> body) async {
    try {
      return await w2dClient.cartSync(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CartModel> getCart(Map<String, dynamic> queries) async {
    try {
      return await w2dClient.getCart(queries);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UpdatedCartModel> updateCart(Map<String, dynamic> body) async {
    try {
      return await w2dClient.updateCart(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SearchResultAutoCompleteModel> searchProductAutoComplete(
    Map<String, dynamic> queries,
  ) async {
    try {
      return await w2dClient.searchProductAutoComplete(queries);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CalculateInsuranceModel> calculateInsurance(
    Map<String, dynamic> body,
  ) async {
    try {
      return await shippingClient.calculateInsurance(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ConfirmInsuranceModel> confirmInsurance(
    Map<String, dynamic> body,
  ) async {
    try {
      return await shippingClient.confirmInsurance(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FreightQuoteModel> getFreightQuote(Map<String, dynamic> body) async {
    try {
      return await shippingClient.getFreightQuote(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SelectFreightServiceModel> selectFreightService(
    Map<String, dynamic> body,
  ) async {
    try {
      return await shippingClient.selectFreightService(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<TelrPaymentResponseModel> initiatePayment(
    PaymentRequestEntity request,
  ) async {
    try {
      final xmlBody = TelrPaymentRequestModel.toXml(request);
      final telrResponse = await telrPaymentClient.initiateTelrPayment(xmlBody);
      final response = TelrPaymentResponseModel.fromXml(telrResponse.data);

      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<TelrConfirmPaymentResponseModel> verifyPayment(
    String transCode,
  ) async {
    try {
      final xmlBody = TelrConfirmPaymentRequestModel.toXml(transCode);
      final telrResponse = await telrPaymentClient.confirmTelrPayment(xmlBody);
      final response = TelrConfirmPaymentResponseModel.fromXml(
        telrResponse.data,
      );

      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CustomerAddressesModel> getCustomerAddresses() async {
    try {
      return await w2dClient.getCustomerAddresses();
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future saveCustomerAddress(Map<String, dynamic> body) async {
    try {
      return await w2dClient.saveCustomerAddress(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OrderPendingModel> orderPending(Map<String, dynamic> body) async {
    try {
      return await w2dClient.orderPending(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future orderSuccess(Map<String, dynamic> body) async {
    try {
      return await w2dClient.orderSuccess(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future cancelOrder(String id) async {
    try {
      return await w2dClient.deleteOrderByID(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future getOrderByID(String id) async {
    try {
      return await w2dClient.getOrdersByID(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OrderListModel> getOrdersList(Map<String, dynamic> body) async {
    try {
      return await w2dClient.getOrders(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future updateOrder({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await w2dClient.updateOrderByID(id: id, body: body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> addWishlist(Map<String, dynamic> body) async {
    try {
      return await w2dClient.addWishlist(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GetWishListModel> getWishlist() async {
    try {
      return await w2dClient.getWishlist();
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> deleteWishlist(String id) async {
    try {
      return await w2dClient.deleteWishlist(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RecommendationsModel> getRecommendations(String productId) async {
    try {
      return await w2dClient.getRecommendations(productId);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RelatedProductsModel> getRelatedProducts(String productId) async {
    try {
      return await w2dClient.getRelatedProducts(productId);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }
}
