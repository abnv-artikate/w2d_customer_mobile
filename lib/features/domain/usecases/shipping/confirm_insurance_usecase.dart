import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class ConfirmInsuranceUseCase
    extends UseCase<ConfirmInsuranceEntity, ConfirmInsuranceParams> {
  final Repository repository;

  ConfirmInsuranceUseCase(this.repository);

  @override
  Future<Either<Failure, ConfirmInsuranceEntity>> call(
    ConfirmInsuranceParams params,
  ) async {
    return await repository.confirmInsurance(params: params);
  }
}

class ConfirmInsuranceParams {
  final String quoteToken;
  final bool addInsurance;

  ConfirmInsuranceParams({
    required this.quoteToken,
    required this.addInsurance,
  });
}
