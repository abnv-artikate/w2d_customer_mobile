part of 'common_cubit.dart';

sealed class CommonState {}

final class CommonInitial extends CommonState {}

final class CommonLoading extends CommonState {}

final class CollectionsLoading extends CommonState {}

final class CollectionsLoaded extends CommonState {
  final List<CollectionsResultDataEntity> collections;

  CollectionsLoaded({required this.collections});
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

final class CommonError extends CommonState {
  final String error;

  CommonError(this.error);
}

final class AuthLoading extends CommonState {}

final class SendOtpSuccess extends CommonState {
  final String message;

  SendOtpSuccess(this.message);
}

final class VerifyOtpSuccess extends CommonState {
  final UserEntity userEntity;

  VerifyOtpSuccess(this.userEntity);
}

final class AuthError extends CommonState {
  final String error;

  AuthError({required this.error});
}

final class LogOut extends CommonState {}
