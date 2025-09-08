import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/wishlist/wishlist_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetWishListUseCase extends UseCase<WishListEntity, NoParams> {
  final Repository _repository;

  GetWishListUseCase(this._repository);

  @override
  Future<Either<Failure, WishListEntity>> call(NoParams params) {
    return _repository.getWishlist();
  }
}
