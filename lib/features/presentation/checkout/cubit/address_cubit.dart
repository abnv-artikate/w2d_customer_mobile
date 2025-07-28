import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/get_address_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.createAddressUseCase,
    required this.getAddressUseCase,
  }) : super(AddressInitial());

  final CreateAddressUseCase createAddressUseCase;
  final GetAddressUseCase getAddressUseCase;

  saveAddress(CreateAddressParams params) async {
    emit(CreateAddressLoading());
    final result = await createAddressUseCase.call(params);

    result.fold(
      (l) {
        emit(CreateAddressError(error: l.message));
      },
      (r) {
        emit(CreateAddressLoaded());
      },
    );
  }

  getSavedAddress() async {
    emit(GetSavedAddressLoading());
    final result = await getAddressUseCase.call(NoParams());

    result.fold(
      (l) {
        emit(GetSavedAddressError(error: l.message));
      },
      (data) {
        emit(GetSavedAddressLoaded(list: data));
      },
    );
  }

  void selectAddress(int addressID) {
    emit(SelectSavedAddress(addressID: addressID));
  }
}
