import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/vouchers/validate_voucher_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class ValidateVoucherUseCase extends UseCase<ValidateVoucherEntity, ValidateVoucherParams> {
  final Repository _repository;

  ValidateVoucherUseCase(this._repository);

  @override
  Future<Either<Failure, ValidateVoucherEntity>> call(ValidateVoucherParams params) {
    return _repository.validateVoucher(params);
  }
}

class ValidateVoucherParams {
  final String voucherCode;
  final String cartTotal;

  ValidateVoucherParams({required this.voucherCode, required this.cartTotal});

  Map<String, dynamic> toJson() {
    return {"voucher_code": voucherCode, "cart_total": cartTotal};
  }
}
