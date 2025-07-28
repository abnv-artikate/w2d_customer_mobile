part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class CreateAddressLoading extends AddressState {}

final class CreateAddressLoaded extends AddressState {}

final class CreateAddressError extends AddressState {
  final String error;

  CreateAddressError({required this.error});
}

final class GetSavedAddressLoading extends AddressState {}

final class GetSavedAddressLoaded extends AddressState {
  final List<CustomerAddressesEntity> list;

  GetSavedAddressLoaded({required this.list});
}

final class GetSavedAddressError extends AddressState {
  final String error;

  GetSavedAddressError({required this.error});
}

final class SelectSavedAddress extends AddressState {
  final int addressID;

  SelectSavedAddress({required this.addressID});
}
