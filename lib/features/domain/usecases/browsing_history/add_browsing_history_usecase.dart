import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class AddBrowsingHistoryUseCase
    extends UseCase<String, AddBrowsingHistoryParams> {
  final Repository _repository;

  AddBrowsingHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(AddBrowsingHistoryParams params) async {
    return await _repository.addBrowsingHistory(params);
  }
}

class AddBrowsingHistoryParams {
  final String productId;

  AddBrowsingHistoryParams({required this.productId});
}
