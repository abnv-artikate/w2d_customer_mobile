import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w2d_customer_mobile/core/utils/endpoint_constants.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/calculate_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/confirm_insurance_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/freight_quote_model.dart';
import 'package:w2d_customer_mobile/features/data/model/shipping/select_freight_service_model.dart';

part 'shipping_client.g.dart';

// Use below command to generate
// dart run build_runner build -d

@RestApi()
abstract class ShippingClient {
  factory ShippingClient(final Dio dio) {
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
    dio.options.headers['content-type'] = 'application/json';
    dio.options.headers['token'] =
        '5784929a71_5c1c3b106_cd070e6a_1609b07_2d66eb_33689_8ef4_f2c_68_3_S2D_4_37_79d_a247_46736_9e047d_4219fd9_6aed26e1_634f3b202_6ac32fbd72';
    dio.options.headers['authorization'] = 'Basic Og==';
    return _ShippingClient(dio);
  }

  /// Cargo Shipping Client
  @POST(EndPoints.getFreightQuote)
  Future<FreightQuoteModel> getFreightQuote(@Body() Map<String, dynamic> body);

  @POST(EndPoints.selectFreightService)
  Future<SelectFreightServiceModel> selectFreightService(
    @Body() Map<String, dynamic> body,
  );

  @POST(EndPoints.calculateInsurance)
  Future<CalculateInsuranceModel> calculateInsurance(
    @Body() Map<String, dynamic> body,
  );

  @POST(EndPoints.confirmInsurance)
  Future<ConfirmInsuranceModel> confirmInsurance(
    @Body() Map<String, dynamic> body,
  );

  // @POST(EndPoints.addJob)
  // Future addJob(@Body() Map<String, dynamic> body);
}
