import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetOrdersByIdUseCase extends UseCase<String, String> {
  final Repository _repository;

  GetOrdersByIdUseCase(this._repository);
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await _repository.getOrderByID(params);
  }
}