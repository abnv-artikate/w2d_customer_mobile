part of 'common_cubit.dart';

sealed class CommonState {}

final class CommonInitial extends CommonState {}

final class CommonLoading extends CommonState {}

final class CommonCategoriesLoaded extends CommonState {
  final List<ProductCategoryEntity> categoriesList;

  CommonCategoriesLoaded({required this.categoriesList});
}

final class GetLocationLoading extends CommonState {}

final class GetLocationLoaded extends CommonState {
  final LocationEntity location;

  GetLocationLoaded({required this.location});
}

final class GetLocationError extends CommonState {
  final String error;

  GetLocationError({required this.error});
}

final class CommonError extends CommonState {
  final String error;

  CommonError(this.error);
}
