import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/core/utils/endpoint_constants.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/updated_cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_hierarchy_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

part 'client.g.dart';

// Use below command to generate
// dart run build_runner build -d

@RestApi()
abstract class W2DClient {
  factory W2DClient(final Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          log(
            "${e.requestOptions.baseUrl}${e.requestOptions.path}",
            name: "Logout ${e.response?.statusCode}",
          );
          return handler.next(e);
        },
      ),
    );
    return _W2DClient(dio);
  }

  /// Auth Client
  @POST(EndPoints.sendOtp)
  Future<SuccessMessageModel> sendOtp({
    @Queries() required Map<String, dynamic> queries,
    @Body() required Map<String, dynamic> body,
  });

  @POST(EndPoints.verifyOtp)
  Future<VerifyOtpModel> verifyOtp(@Body() Map<String, dynamic> body);

  // @POST(EndPoints.createCustomer)
  // Future<SuccessMessageModel> createCustomer(@Body() Map<String, dynamic> body);

  /// Categories Client

  @GET(EndPoints.categories)
  Future<ProductCategoryListModel> getProductCategoryListing(
    @Queries() Map<String, dynamic> query,
  );

  @GET(EndPoints.categoriesHierarchy)
  Future<CategoryHierarchyModel> getCategoryHierarchy();

  /// Product Client
  @GET('${EndPoints.productView}/{id}/')
  Future<ProductViewModel> getProductDetail(@Path() String id);

  /// Cart-Sync Client
  @POST(EndPoints.cartSync)
  Future<SuccessMessageModel> cartSync(@Body() Map<String, dynamic> body);

  /// Cart Client
  @GET(EndPoints.cart)
  Future<CartModel> getCart(@Queries() Map<String, dynamic> queries);

  @POST(EndPoints.cartUpdate)
  Future<UpdatedCartModel> updateCart(@Body() Map<String, dynamic> body);
}
