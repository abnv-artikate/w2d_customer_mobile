import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class SearchProductAutoCompleteUseCase
    extends UseCase<SearchResultAutoCompleteEntity, String> {
  final Repository _repository;

  SearchProductAutoCompleteUseCase(this._repository);

  @override
  Future<Either<Failure, SearchResultAutoCompleteEntity>> call(
    String query,
  ) async {
    return await _repository.searchProductAutoComplete(params: query);
  }
}
