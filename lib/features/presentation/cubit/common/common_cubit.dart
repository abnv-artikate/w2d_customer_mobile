import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/get_collections_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/search/search_autocomplete_usecase.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit({
    required this.localDatasource,
    required this.categoriesHierarchyUseCase,
    required this.getCollectionsUseCase,
    required this.searchProductAutoCompleteUseCase,
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
  }) : super(CommonInitial());

  final CategoriesHierarchyUseCase categoriesHierarchyUseCase;
  final GetCollectionsUseCase getCollectionsUseCase;
  final SearchProductAutoCompleteUseCase searchProductAutoCompleteUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final LocalDatasource localDatasource;

  sendOtp(SendOtpParams params) async {
    emit(AuthLoading());
    final result = await sendOtpUseCase(params);
    result.fold((l) => _emitFailure(l), (data) {
      emit(SendOtpSuccess(data));
    });
  }

  verifyOtp(VerifyOtpParams params) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase(params);
    result.fold((l) => _emitFailure(l), (data) {
      emit(VerifyOtpSuccess(data));
    });
  }

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
        emit(CollectionsLoaded(collections: res.results.data));
      },
    );
  }

  String getUserEmail() {
    return localDatasource.getUserEmail() ?? "";
  }

  String getUserName() {
    return localDatasource.getUserName() ?? "";
  }

  bool isUserLoggedIn() {
    return localDatasource.getUserEmail() != null;
  }

  void logout() {
    localDatasource.logout();
    emit(LogOut());
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
