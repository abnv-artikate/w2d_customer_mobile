import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetAddressUseCase extends UseCase<List<CustomerAddressesEntity>, NoParams> {
  final Repository _repository;

  GetAddressUseCase(this._repository);

  @override
  Future<Either<Failure, List<CustomerAddressesEntity>>> call(NoParams params) {
    return _repository.getCustomerAddresses();
  }
}
