import 'package:dio/dio.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/client/shipping_client.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/updated_cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/collections_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/search/search_result_autocomplete_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/calculate_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/confirm_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/freight_quote_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/select_freight_service_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

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
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final W2DClient w2dClient;
  final ShippingClient shippingClient;

  RemoteDatasourceImpl({required this.shippingClient, required this.w2dClient});

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
}
