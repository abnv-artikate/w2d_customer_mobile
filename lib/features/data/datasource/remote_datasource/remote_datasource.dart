import 'package:dio/dio.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_hierarchy_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

abstract class RemoteDatasource {
  /// Auth Datasource
  Future<SuccessMessageModel> sendOtp({
    required Map<String, dynamic> queries,
    required Map<String, dynamic> body,
  });

  Future<VerifyOtpModel> verifyOtp(Map<String, dynamic> body);

  /// Categories Datasource
  Future<List<ProductCategoryListModel>> getProductCategoriesList(
    Map<String, dynamic> query,
  );

  Future<CategoryHierarchyModel> getCategoriesHierarchyModel();

  /// Product Datasource
  Future<ProductViewModel> getProductView(String id);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final RestClient client;

  RemoteDatasourceImpl({required this.client});

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
      return await client.sendOtp(queries: queries, body: body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtp(Map<String, dynamic> body) async {
    try {
      return await client.verifyOtp(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<CategoryHierarchyModel> getCategoriesHierarchyModel() async {
    try {
      return await client.getCategoryHierarchy();
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<ProductCategoryListModel>> getProductCategoriesList(
    Map<String, dynamic> query,
  ) async {
    try {
      return await client.getProductCategoryListing(query);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ProductViewModel> getProductView(String id) async {
    try {
      return await client.getProductDetail(id);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }
}
