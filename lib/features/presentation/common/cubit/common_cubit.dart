import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit({
    required this.localDatasource,
    required this.categoriesHierarchyUseCase,
    required this.getCurrentLocationUseCase,
  }) : super(CommonInitial());

  final CategoriesHierarchyUseCase categoriesHierarchyUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final LocalDatasource localDatasource;

  getCategoriesList() async {
    emit(CommonLoading());
    final result = await categoriesHierarchyUseCase(NoParams());

    result.fold((l) => _emitFailure(l), (r) {
      emit(CommonCategoriesLoaded(categoriesList: r));
    });
  }

  getCurrentLocation() async {
    emit(GetLocationLoading());
    final result = await getCurrentLocationUseCase.call();

    result.fold(
      (err) {
        emit(GetLocationError(error: err));
      },
      (data) async {
        String location = await _getAddressFromLatLng(data);
        emit(GetLocationLoaded(location: location));
      },
    );
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placeMarks[0];

      return "${place.subLocality}, ${place.locality}";
    } catch (e) {
      return e.toString();
    }
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
