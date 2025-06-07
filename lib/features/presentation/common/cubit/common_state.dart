part of 'common_cubit.dart';

sealed class CommonState {}

final class CommonInitial extends CommonState {}

final class CommonLoading extends CommonState {}

final class CollectionsLoading extends CommonState {}

final class CollectionsLoaded extends CommonState {
  final List<CollectionsResultDataEntity> brandMallCollections;
  final List<CollectionsResultDataEntity> hiddenGemsCollections;

  CollectionsLoaded({
    required this.brandMallCollections,
    required this.hiddenGemsCollections,
  });
}

final class CollectionsError extends CommonState {
  final String error;

  CollectionsError({required this.error});
}

final class SearchAutoCompleteLoaded extends CommonState {
  final SearchResultAutoCompleteEntity entity;

  SearchAutoCompleteLoaded({required this.entity});
}

final class SearchError extends CommonState {
  final String error;

  SearchError({required this.error});
}

final class CommonCategoriesLoaded extends CommonState {
  final List<SubCategoriesEntity> categoriesList;

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
