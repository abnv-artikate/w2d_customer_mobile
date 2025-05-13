import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit({
    required this.localDatasource,
    required this.categoriesHierarchyUseCase,
  }) : super(CommonInitial());

  final CategoriesHierarchyUseCase categoriesHierarchyUseCase;
  final LocalDatasource localDatasource;

  getCategoriesList() async {
    emit(CommonLoading());
    final result = await categoriesHierarchyUseCase(NoParams());

    result.fold((l) => _emitFailure(l), (r) {
      emit(CommonCategoriesLoaded(categoriesList: r));
    });
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
