import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/core/utils/endpoint_constants.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/data/model/address/get_customer_addresses_model.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/cart/updated_cart_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/category_model.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/product_category_list_model.dart';
import 'package:w2d_customer_mobile/features/data/model/collections_model.dart';
import 'package:w2d_customer_mobile/features/data/model/product/product_view_model.dart';
import 'package:w2d_customer_mobile/features/data/model/search/search_result_autocomplete_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

part 'client.g.dart';

// Use below command to generate
// dart run build_runner build -d

@RestApi()
abstract class W2DClient {
  factory W2DClient(final Dio dio, final LocalDatasource localDatasource) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          final token = localDatasource.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = localDatasource.getRefreshToken();

            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                log('Attempting to refresh token', name: 'W2DClient');

                // Create a new Dio instance to avoid interceptor conflicts
                final refreshDio = Dio();

                final refreshResponse = await refreshDio.post(
                  '${Constants.w2dBaseUrl}${EndPoints.tokenRefresh}',
                  data: {'refresh': refreshToken},
                );

                // Check if refresh was successful
                if (refreshResponse.statusCode == 200) {
                  final responseData = refreshResponse.data;

                  // Try different possible key names for access token
                  final newAccessToken =
                      responseData['access_token'] ??
                      responseData['access'] ??
                      responseData['accessToken'];

                  // Try different possible key names for refresh token
                  final newRefreshToken =
                      responseData['refresh_token'] ??
                      responseData['refresh'] ??
                      responseData['refreshToken'];

                  if (newAccessToken != null) {
                    // Save new tokens
                    await localDatasource.setAccessToken(newAccessToken);
                    if (newRefreshToken != null) {
                      await localDatasource.setRefreshToken(newRefreshToken);
                    }

                    // Retry original request with new token
                    final opts = e.requestOptions;
                    opts.headers['Authorization'] = 'Bearer $newAccessToken';

                    log(
                      'Token refreshed successfully, retrying original request',
                      name: 'W2DClient',
                    );

                    final cloneResponse = await dio.fetch(opts);
                    return handler.resolve(cloneResponse);
                  } else {
                    log('Invalid refresh response format', name: 'W2DClient');
                    await localDatasource.logout();
                    return handler.next(e);
                  }
                } else {
                  log(
                    'Token refresh failed with status: ${refreshResponse.statusCode}',
                    name: 'W2DClient',
                  );
                  await localDatasource.logout();
                  return handler.next(e);
                }
              } catch (refreshError) {
                log('Token refresh error: $refreshError', name: 'W2DClient');

                // If refresh fails, logout and continue with original error
                await localDatasource.logout();
                return handler.next(e);
              }
            } else {
              log('No refresh token available', name: 'W2DClient');
              await localDatasource.logout();
              return handler.next(e);
            }
          }

          // Log other errors for debugging
          log(
            "Request failed: ${e.requestOptions.baseUrl}${e.requestOptions.path}",
            name: "W2DClient Error ${e.response?.statusCode}",
          );
          return handler.next(e);
        },
      ),
    );
    return _W2DClient(dio, baseUrl: Constants.w2dBaseUrl);
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
  Future<CategoriesModel> getCategoryHierarchy();

  @GET(EndPoints.collections)
  Future<CollectionsModel> getCollections();

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

  /// Search Client
  @GET(EndPoints.searchAutoComplete)
  Future<SearchResultAutoCompleteModel> searchProductAutoComplete(
    @Queries() Map<String, dynamic> queries,
  );

  ///
  @POST(EndPoints.customerAddress)
  Future saveCustomerAddress(@Body() Map<String, dynamic> body);

  @GET(EndPoints.customerAddresses)
  Future<CustomerAddressesModel> getCustomerAddresses();


  /// Order Client
  @POST(EndPoints.orderPending)
  Future orderPending(@Body() Map<String, dynamic> body);

  @POST(EndPoints.orderSuccess)
  Future orderSuccess(@Body() Map<String, dynamic> body);
}
