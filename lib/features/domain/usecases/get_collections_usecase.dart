import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetCollectionsUseCase extends UseCase<CollectionsEntity,NoParams>{
  final Repository repository;

  GetCollectionsUseCase(this.repository);
  @override
  Future<Either<Failure, CollectionsEntity>> call(NoParams params) {
    return repository.getCollections();
  }
}