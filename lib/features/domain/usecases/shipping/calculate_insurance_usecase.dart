import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class CalculateInsuranceUseCase
    extends UseCase<CalculateInsuranceEntity, CalculateInsuranceParams> {
  final Repository repository;

  CalculateInsuranceUseCase(this.repository);

  @override
  Future<Either<Failure, CalculateInsuranceEntity>> call(
    CalculateInsuranceParams params,
  ) async {
    return await repository.calculateInsurance(params: params);
  }
}

class CalculateInsuranceParams {
  final String quoteToken;

  CalculateInsuranceParams({required this.quoteToken});
}
