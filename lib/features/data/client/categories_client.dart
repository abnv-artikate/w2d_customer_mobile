import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/features/data/model/categories/hierarchy_model.dart';

part 'categories_client.g.dart';

// Use below command to generate
// flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class CategoriesRestClient {
  factory CategoriesRestClient(final Dio dio) {
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
    return _CategoriesRestClient(dio);
  }

  @POST('/customer/send-otp')
  Future<CategoriesHierarchyModel> sendOtp(@Body() Map<String, dynamic> map);
}
