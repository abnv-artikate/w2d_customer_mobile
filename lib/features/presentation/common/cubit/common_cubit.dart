import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/get_collections_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/search/search_autocomplete_usecase.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit({
    required this.localDatasource,
    required this.categoriesHierarchyUseCase,
    required this.getCurrentLocationUseCase,
    required this.getCollectionsUseCase,
    required this.searchProductAutoCompleteUseCase,
  }) : super(CommonInitial());

  final CategoriesHierarchyUseCase categoriesHierarchyUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetCollectionsUseCase getCollectionsUseCase;
  final SearchProductAutoCompleteUseCase searchProductAutoCompleteUseCase;
  final LocalDatasource localDatasource;

  List<CollectionsResultDataEntity> brandMallCollections = [];
  List<CollectionsResultDataEntity> hiddenGemsCollections = [];

  getCategoriesList() async {
    emit(CommonLoading());
    final result = await categoriesHierarchyUseCase.call(NoParams());

    result.fold((l) => _emitFailure(l), (r) {
      emit(CommonCategoriesLoaded(categoriesList: r));
    });
  }

  search({required String query}) async {
    final result = await searchProductAutoCompleteUseCase.call(query);

    result.fold(
      (l) {
        emit(SearchError(error: l.message));
      },
      (data) {
        emit(SearchAutoCompleteLoaded(entity: data));
      },
    );
  }

  getCollections() async {
    emit(CollectionsLoading());
    final result = await getCollectionsUseCase.call(NoParams());

    result.fold(
      (l) {
        emit(CollectionsError(error: l.message));
      },
      (res) {
        for (CollectionsResultDataEntity item in res.results.data) {
          if (item.name.startsWith("Brand Mall")) {
            brandMallCollections.add(item);
          } else {
            hiddenGemsCollections.add(item);
          }
        }

        emit(
          CollectionsLoaded(
            brandMallCollections: brandMallCollections,
            hiddenGemsCollections: hiddenGemsCollections,
          ),
        );
      },
    );
  }

  getCurrentLocation() async {
    emit(GetLocationLoading());
    final result = await getCurrentLocationUseCase.call();

    result.fold(
      (err) {
        emit(GetLocationError(error: err));
      },
      (data) {
        emit(GetLocationLoaded(location: data));
      },
    );
  }

  bool isUserLoggedIn() {
    return localDatasource.getUserEmail() != null;
  }

  FutureOr<void> _emitFailure(Failure failure) async {
    if (failure is ServerFailure) {
      emit(CommonError(failure.message));
    } else if (failure is CacheFailure) {
      emit(CommonError(failure.message));
    } else {
      emit(CommonError(failure.message));
    }
  }
}
