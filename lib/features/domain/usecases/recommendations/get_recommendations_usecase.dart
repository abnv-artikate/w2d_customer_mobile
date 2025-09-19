import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/recommendations/recommendations_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetRecommendationsUseCase
    extends UseCase<RecommendationsEntity, GetRecommendationsParams> {
  final Repository _repository;

  GetRecommendationsUseCase(this._repository);

  @override
  Future<Either<Failure, RecommendationsEntity>> call(GetRecommendationsParams params) {
    return _repository.getRecommendations(params.productId);
  }}

class GetRecommendationsParams {
  final String productId;

  GetRecommendationsParams({required this.productId});
}
