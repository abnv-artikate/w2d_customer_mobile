import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class CategoriesHierarchyUseCase
    extends UseCase<List<ProductCategoryEntity>, NoParams> {
  final Repository _repository;

  CategoriesHierarchyUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductCategoryEntity>>> call(
    NoParams params,
  ) async {
    return await _repository.getCategoriesHierarchy();
  }
}
