import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/core/utils/endpoint_constants.dart';

part 'telr_payment_client.g.dart';

@RestApi()
abstract class TelrPaymentClient {
  factory TelrPaymentClient(final Dio dio) {
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
    return _TelrPaymentClient(dio, baseUrl: Constants.telrPaymentBaseUrl);
  }

  @POST(EndPoints.createPayment)
  Future<HttpResponse<String>> initiateTelrPayment(@Body() String xmlBody);

  @POST(EndPoints.confirmPayment)
  Future<HttpResponse<String>> confirmTelrPayment(@Body() String xmlBody);
}
