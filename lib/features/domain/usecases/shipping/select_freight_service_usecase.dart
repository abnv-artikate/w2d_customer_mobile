import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class SelectFreightServiceUseCase
    extends UseCase<SelectFreightServiceEntity, SelectFreightServiceParams> {
  final Repository repository;

  SelectFreightServiceUseCase(this.repository);

  @override
  Future<Either<Failure, SelectFreightServiceEntity>> call(
    SelectFreightServiceParams params,
  ) async {
    return await repository.selectFreightService(params: params);
  }
}

class SelectFreightServiceParams {
  final String quoteToken;
  final String selectedCourierType;

  SelectFreightServiceParams({
    required this.quoteToken,
    required this.selectedCourierType,
  });
}
