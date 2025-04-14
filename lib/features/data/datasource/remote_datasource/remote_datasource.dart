import 'package:dio/dio.dart';
import 'package:w2d_customer_mobile/core/error/exceptions.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/model/success_message_model.dart';

abstract class RemoteDatasource {
  Future<SuccessMessageModel> sendOtp({
    required Map<String, dynamic> queries,
    required Map<String, dynamic> body,
  });

  Future<SuccessMessageModel> verifyOtp(Map<String, dynamic> body);
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
  Future<SuccessMessageModel> verifyOtp(Map<String, dynamic> body) async {
    try {
      return await client.verifyOtp(body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on Exception {
      rethrow;
    }
  }
}
