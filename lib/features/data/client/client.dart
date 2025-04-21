import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/core/utils/endpoint_constants.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

part 'client.g.dart';

// Use below command to generate
// flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class RestClient {
  factory RestClient(final Dio dio) {
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
    return _RestClient(dio);
  }

  @POST(EndPoints.sendOtp)
  Future<SuccessMessageModel> sendOtp({
    @Queries() required Map<String, dynamic> queries,
    @Body() required Map<String, dynamic> body,
  });

  @POST(EndPoints.verifyOtp)
  Future<VerifyOtpModel> verifyOtp(@Body() Map<String, dynamic> body);

  // @POST(EndPoints.createCustomer)
  // Future<SuccessMessageModel> createCustomer(@Body() Map<String, dynamic> body);
}
