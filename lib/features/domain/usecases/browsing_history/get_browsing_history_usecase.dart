import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/browsing_history/browsing_history_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetBrowsingHistoryUseCase
    extends UseCase<BrowsingHistoryEntity, NoParams> {
  final Repository _repository;

  GetBrowsingHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, BrowsingHistoryEntity>> call(NoParams params) async {
    return await _repository.getBrowsingHistory();
  }
}
