import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/vouchers/vouchers_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetVouchersUseCase
    extends UseCase<List<VouchersEntity>, GetVouchersParams> {
  final Repository _repository;

  GetVouchersUseCase(this._repository);

  @override
  Future<Either<Failure, List<VouchersEntity>>> call(GetVouchersParams params) {
    return _repository.getVouchers(params);
  }
}

class GetVouchersParams {
  final String cartTotal;

  GetVouchersParams({required this.cartTotal});

  Map<String, dynamic> toJson() {
    return {"cart_total": cartTotal};
  }
}
