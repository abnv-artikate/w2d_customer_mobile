import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_manual_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';

part 'cart_shipping_state.dart';

class CartShippingCubit extends Cubit<CartShippingState> {
  CartShippingCubit({
    required this.cartSyncUseCase,
    required this.getCartItemUseCase,
    required this.getCurrentLocationUseCase,
    required this.getManualLocationUseCase,
    required this.updateCartUseCase,
    required this.getFreightQuoteUseCase,
    required this.selectFreightServiceUseCase,
    required this.calculateInsuranceUseCase,
    required this.confirmInsuranceUseCase,
  }) : super(CartShippingInitial());

  // Cart Use Cases
  final CartSyncUseCase cartSyncUseCase;
  final GetCartUseCase getCartItemUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetManualLocationUseCase getManualLocationUseCase;
  final UpdateCartUseCase updateCartUseCase;

  // Shipping Use Cases
  final GetFreightQuoteUseCase getFreightQuoteUseCase;
  final SelectFreightServiceUseCase selectFreightServiceUseCase;
  final CalculateInsuranceUseCase calculateInsuranceUseCase;
  final ConfirmInsuranceUseCase confirmInsuranceUseCase;

  // Constants
  static const double _platformFeeRate = 0.02;

  // Current state data
  CartEntity? _currentCart;
  LocationEntity? _currentLocation;
  FreightQuoteEntityData? _currentFreightQuote;
  CalculateInsuranceEntity? _currentInsuranceData;
  int? _selectedShippingIndex;
  bool _isTransitInsured = false;

  // Getters for current data
  CartEntity? get currentCart => _currentCart;

  LocationEntity? get currentLocation => _currentLocation;

  FreightQuoteEntityData? get currentFreightQuote => _currentFreightQuote;

  CalculateInsuranceEntity? get currentInsuranceData => _currentInsuranceData;

  int? get selectedShippingIndex => _selectedShippingIndex;

  bool get isTransitInsured => _isTransitInsured;

  // Cart Operations
  Future<void> getCurrentLocation() async {
    // emit(state.copyWith(locationStatus: LoadingStatus.loading));
    final result = await getCurrentLocationUseCase.call();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            locationStatus: LoadingStatus.error,
            errorMessage: failure,
          ),
        );
      },
      (location) {
        _currentLocation = location;
        emit(
          state.copyWith(
            locationStatus: LoadingStatus.loaded,
            location: location,
          ),
        );
      },
    );
  }

  Future<void> getManualLocation(GetManualLocationParams params) async {
    // emit(state.copyWith(locationStatus: LoadingStatus.loading));

    final result = await getManualLocationUseCase.call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            locationStatus: LoadingStatus.error,
            errorMessage: failure,
          ),
        );
      },
      (location) {
        _currentLocation = location;
        _calculateAndEmitFees();
        emit(
          state.copyWith(
            locationStatus: LoadingStatus.loaded,
            location: location,
          ),
        );
      },
    );
  }

  Future<void> cartSync({required CartSyncParams params}) async {
    // emit(state.copyWith(cartStatus: LoadingStatus.loading));

    final result = await cartSyncUseCase.call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            cartStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        emit(
          state.copyWith(
            cartStatus: LoadingStatus.loaded,
            successMessage: message,
          ),
        );
      },
    );
  }

  Future<void> getCartItems() async {
    // emit(state.copyWith(cartStatus: LoadingStatus.loading));

    final result = await getCartItemUseCase.call(NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            cartStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (cart) {
        _currentCart = cart;
        emit(state.copyWith(cartStatus: LoadingStatus.loaded, cart: cart));

        // Auto-calculate fees when cart is loaded
        _calculateAndEmitFees();
      },
    );
  }

  Future<void> updateCart(UpdateCartParams params) async {
    final result = await updateCartUseCase.call(params);
    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (response) {
        emit(state.copyWith(successMessage: response.message));
        // Refresh cart after update
        getCartItems();
      },
    );
  }

  // Shipping Operations
  Future<void> getFreightQuote({required GetFreightQuoteParams params}) async {
    // emit(state.copyWith(freightQuoteStatus: LoadingStatus.loading));

    final result = await getFreightQuoteUseCase.call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            freightQuoteStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (freightQuote) {
        _currentFreightQuote = freightQuote.data;
        emit(
          state.copyWith(
            freightQuoteStatus: LoadingStatus.loaded,
            freightQuote: freightQuote.data,
          ),
        );
      },
    );
  }

  Future<void> selectFreightService(SelectFreightServiceParams params) async {
    // emit(state.copyWith(shippingSelectionStatus: LoadingStatus.loading));

    _selectedShippingIndex = params.serviceIndex;

    final result = await selectFreightServiceUseCase.call(params);
    result.fold(
      (failure) {
        _selectedShippingIndex = null;
        emit(
          state.copyWith(
            shippingSelectionStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (response) {
        _selectedShippingIndex =
            params.serviceIndex; // Assuming this exists in params
        emit(
          state.copyWith(
            shippingSelectionStatus: LoadingStatus.loaded,
            selectedShippingIndex: _selectedShippingIndex,
            successMessage: response.message,
          ),
        );

        // Recalculate fees after shipping selection
        _calculateAndEmitFees();
      },
    );
  }

  Future<void> calculateInsurance(CalculateInsuranceParams params) async {
    // emit(state.copyWith(insuranceStatus: LoadingStatus.loading));

    final result = await calculateInsuranceUseCase.call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            insuranceStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (insurance) {
        _currentInsuranceData = insurance;
        emit(
          state.copyWith(
            insuranceStatus: LoadingStatus.loaded,
            insuranceData: insurance,
          ),
        );

        // Recalculate fees after insurance calculation
        _calculateAndEmitFees();
      },
    );
  }

  Future<void> confirmInsurance(ConfirmInsuranceParams params) async {
    // emit(state.copyWith(insuranceConfirmationStatus: LoadingStatus.loading));

    final result = await confirmInsuranceUseCase.call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            insuranceConfirmationStatus: LoadingStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            insuranceConfirmationStatus: LoadingStatus.loaded,
            successMessage: response.message,
          ),
        );
      },
    );
  }

  // Fee Calculation Methods
  void updateTransitInsurance(bool isInsured) {
    _isTransitInsured = isInsured;
    _calculateAndEmitFees();
  }

  void updateSelectedShippingIndex(int? index) {
    _selectedShippingIndex = index;
    _calculateAndEmitFees();
  }

  void _calculateAndEmitFees() {
    if (_currentCart?.items == null) return;

    try {
      // emit(state.copyWith(feeCalculationStatus: LoadingStatus.loading));

      final cartItems = _currentCart!.items;
      final goodsValue = _calculateGoodsValue(cartItems);
      final localTransitFees = _calculateLocalTransitFees(cartItems);
      final exportFreightPackingOtherFees =
          _calculateExportFreightPackingOtherFees();
      final destDutyTaxesOtherFees = _calculateDestDutyTaxesOtherFees();
      final transitInsurance = _calculateTransitInsurance();

      final platformFees = _calculatePlatformFees(
        goodsValue: goodsValue,
        exportFreightPackingOtherFees: exportFreightPackingOtherFees,
        transitInsurance: transitInsurance,
        destDutyTaxesOtherFees: destDutyTaxesOtherFees,
      );

      final estimatedTotal =
          goodsValue +
          platformFees +
          localTransitFees +
          exportFreightPackingOtherFees +
          destDutyTaxesOtherFees +
          transitInsurance;

      final feeBreakdown = FeeBreakdown(
        goodsValue: goodsValue,
        platformFees: platformFees,
        localTransitFees: localTransitFees,
        exportFreightPackingOtherFees: exportFreightPackingOtherFees,
        destDutyTaxesOtherFees: destDutyTaxesOtherFees,
        transitInsurance: transitInsurance,
        estimatedTotal: estimatedTotal,
      );

      emit(
        state.copyWith(
          feeCalculationStatus: LoadingStatus.loaded,
          feeBreakdown: feeBreakdown,
          isTransitInsured: _isTransitInsured,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          feeCalculationStatus: LoadingStatus.error,
          errorMessage: 'Error calculating fees: ${e.toString()}',
        ),
      );
    }
  }

  // Private calculation methods
  double _calculateGoodsValue(List<CartItemEntity> cartItems) {
    double totalGoodsValue = 0.0;
    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalGoodsValue += item.product.salePrice * item.quantity;
      }
    }
    return totalGoodsValue;
  }

  double _calculatePlatformFees({
    required double goodsValue,
    required double exportFreightPackingOtherFees,
    required double transitInsurance,
    required double destDutyTaxesOtherFees,
  }) {
    return (_platformFeeRate *
        (goodsValue +
            exportFreightPackingOtherFees +
            transitInsurance +
            destDutyTaxesOtherFees));
  }

  double _calculateLocalTransitFees(List<CartItemEntity> cartItems) {
    double totalTransitFee = 0.0;
    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalTransitFee += item.product.localTransitFee;
      }
    }
    return totalTransitFee;
  }

  double _calculateExportFreightPackingOtherFees() {
    if (_currentFreightQuote == null || _selectedShippingIndex == null) {
      return 0.0;
    }

    // Return the freight amount based on selected shipping method
    switch (_selectedShippingIndex) {
      case 0: // Courier (Air) - Door
        return _currentFreightQuote!.quoteCourier.doorDelivery.totalAmount
            .toDouble();
      case 1: // Air Freight - Door
        return _currentFreightQuote!.quoteAir.doorDelivery.totalAmount
            .toDouble();
      case 2: // Air Freight - Port
        return _currentFreightQuote!.quoteAir.portDelivery.totalAmount
            .toDouble();
      case 3: // Sea Freight - Door
        return _currentFreightQuote!.quoteSea.doorDelivery.totalAmount
            .toDouble();
      case 4: // Sea Freight - Port
        return _currentFreightQuote!.quoteSea.portDelivery.totalAmount
            .toDouble();
      case 5: // Land Freight - Door
        return _currentFreightQuote!.quoteLand.doorDelivery.totalAmount
            .toDouble();
      default:
        return 0.0;
    }
  }

  double _calculateDestDutyTaxesOtherFees() {
    if (_currentFreightQuote == null || _selectedShippingIndex == null) {
      return 0.0;
    }

    // Return the freight amount based on selected shipping method
    switch (_selectedShippingIndex) {
      case 0: // Courier (Air) - Door
        return double.tryParse(
              _currentFreightQuote!.quoteCourier.doorDelivery.totalDutyTax,
            ) ??
            0.0;
      case 1: // Air Freight - Door
        return double.tryParse(
              _currentFreightQuote!.quoteAir.doorDelivery.totalDutyTax,
            ) ??
            0.0;
      case 2: // Air Freight - Port
        return double.tryParse(
              _currentFreightQuote!.quoteAir.portDelivery.totalDutyTax,
            ) ??
            0.0;
      case 3: // Sea Freight - Door
        return double.tryParse(
              _currentFreightQuote!.quoteSea.doorDelivery.totalDutyTax,
            ) ??
            0.0;
      case 4: // Sea Freight - Port
        return double.tryParse(
              _currentFreightQuote!.quoteSea.portDelivery.totalDutyTax,
            ) ??
            0.0;
      case 5: // Land Freight - Door
        return double.tryParse(
              _currentFreightQuote!.quoteLand.doorDelivery.totalDutyTax,
            ) ??
            0.0;
      default:
        return 0.0;
    }
  }

  double _calculateTransitInsurance() {
    return _currentInsuranceData?.data.insuranceAmt ?? 0.0;
  }

  String getShippingMethodName(int? shippingIndex) {
    switch (shippingIndex) {
      case 0:
        return "Courier (air)";
      case 1:
        return "Air Freight (door)";
      case 2:
        return "Air Freight (port)";
      case 3:
        return "Sea Freight (door)";
      case 4:
        return "Sea Freight (port)";
      case 5:
        return "Land Freight (door)";
      default:
        return "Select Shipping Method";
    }
  }

  // Reset methods
  void resetShipping() {
    _currentFreightQuote = null;
    _currentInsuranceData = null;
    _selectedShippingIndex = null;
    _isTransitInsured = false;
    emit(
      state.copyWith(
        freightQuoteStatus: LoadingStatus.initial,
        insuranceStatus: LoadingStatus.initial,
        shippingSelectionStatus: LoadingStatus.initial,
        feeCalculationStatus: LoadingStatus.initial,
        freightQuote: null,
        insuranceData: null,
        selectedShippingIndex: null,
        feeBreakdown: null,
        isTransitInsured: false,
      ),
    );
  }

  void resetAll() {
    _currentCart = null;
    _currentLocation = null;
    _currentFreightQuote = null;
    _currentInsuranceData = null;
    _selectedShippingIndex = null;
    _isTransitInsured = false;
    emit(CartShippingInitial());
  }
}
