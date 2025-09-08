import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class AddWishListUseCase extends UseCase<String, AddWishListParams> {
  final Repository _repository;

  AddWishListUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(AddWishListParams params) {
    return _repository.addWishlist(params);
  }
}

class AddWishListParams {
  final String productId;

  AddWishListParams({required this.productId});

  Map<String, dynamic> toJson() {
    return {"product_id": productId};
  }
}
