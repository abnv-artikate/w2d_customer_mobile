import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit({required this.categoriesHierarchyUseCase})
    : super(CommonInitial());

  final CategoriesHierarchyUseCase categoriesHierarchyUseCase;

  getCategoriesList() async {
    emit(CommonLoading());
    final result = await categoriesHierarchyUseCase(NoParams());

    result.fold((l) => _emitFailure(l), (r) {
      emit(CommonCategoriesLoaded(categoriesList: r));
    });
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
