part of 'cart_shipping_cubit.dart';

enum LoadingStatus { initial, loading, loaded, error }

class CartShippingState {
  // Cart related
  final LoadingStatus cartStatus;
  final CartEntity? cart;

  // Location related
  final LoadingStatus locationStatus;
  final LocationEntity? location;

  // Shipping related
  final LoadingStatus freightQuoteStatus;
  final FreightQuoteEntityData? freightQuote;
  final LoadingStatus shippingSelectionStatus;
  final int? selectedShippingIndex;

  // Insurance related
  final LoadingStatus insuranceStatus;
  final CalculateInsuranceEntity? insuranceData;
  final LoadingStatus insuranceConfirmationStatus;
  final bool isTransitInsured;

  // Fee calculation related
  final LoadingStatus feeCalculationStatus;
  final FeeBreakdown? feeBreakdown;

  // Common
  final String? errorMessage;
  final String? successMessage;

  const CartShippingState({
    this.cartStatus = LoadingStatus.initial,
    this.cart,
    this.locationStatus = LoadingStatus.initial,
    this.location,
    this.freightQuoteStatus = LoadingStatus.initial,
    this.freightQuote,
    this.shippingSelectionStatus = LoadingStatus.initial,
    this.selectedShippingIndex,
    this.insuranceStatus = LoadingStatus.initial,
    this.insuranceData,
    this.insuranceConfirmationStatus = LoadingStatus.initial,
    this.isTransitInsured = false,
    this.feeCalculationStatus = LoadingStatus.initial,
    this.feeBreakdown,
    this.errorMessage,
    this.successMessage,
  });

  CartShippingState copyWith({
    LoadingStatus? cartStatus,
    CartEntity? cart,
    LoadingStatus? locationStatus,
    LocationEntity? location,
    LoadingStatus? freightQuoteStatus,
    FreightQuoteEntityData? freightQuote,
    LoadingStatus? shippingSelectionStatus,
    int? selectedShippingIndex,
    LoadingStatus? insuranceStatus,
    CalculateInsuranceEntity? insuranceData,
    LoadingStatus? insuranceConfirmationStatus,
    bool? isTransitInsured,
    LoadingStatus? feeCalculationStatus,
    FeeBreakdown? feeBreakdown,
    String? errorMessage,
    String? successMessage,
  }) {
    return CartShippingState(
      cartStatus: cartStatus ?? this.cartStatus,
      cart: cart ?? this.cart,
      locationStatus: locationStatus ?? this.locationStatus,
      location: location ?? this.location,
      freightQuoteStatus: freightQuoteStatus ?? this.freightQuoteStatus,
      freightQuote: freightQuote ?? this.freightQuote,
      shippingSelectionStatus:
          shippingSelectionStatus ?? this.shippingSelectionStatus,
      selectedShippingIndex:
          selectedShippingIndex ?? this.selectedShippingIndex,
      insuranceStatus: insuranceStatus ?? this.insuranceStatus,
      insuranceData: insuranceData ?? this.insuranceData,
      insuranceConfirmationStatus:
          insuranceConfirmationStatus ?? this.insuranceConfirmationStatus,
      isTransitInsured: isTransitInsured ?? this.isTransitInsured,
      feeCalculationStatus: feeCalculationStatus ?? this.feeCalculationStatus,
      feeBreakdown: feeBreakdown ?? this.feeBreakdown,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  // Convenience getters for checking loading states
  bool get isCartLoading => cartStatus == LoadingStatus.loading;

  bool get isLocationLoading => locationStatus == LoadingStatus.loading;

  bool get isFreightQuoteLoading => freightQuoteStatus == LoadingStatus.loading;

  bool get isShippingSelectionLoading =>
      shippingSelectionStatus == LoadingStatus.loading;

  bool get isInsuranceLoading => insuranceStatus == LoadingStatus.loading;

  bool get isInsuranceConfirmationLoading =>
      insuranceConfirmationStatus == LoadingStatus.loading;

  bool get isFeeCalculationLoading =>
      feeCalculationStatus == LoadingStatus.loading;

  bool get hasCartData => cart != null && cartStatus == LoadingStatus.loaded;

  bool get hasLocationData =>
      location != null && locationStatus == LoadingStatus.loaded;

  bool get hasFreightQuoteData =>
      freightQuote != null && freightQuoteStatus == LoadingStatus.loaded;

  bool get hasInsuranceData =>
      insuranceData != null && insuranceStatus == LoadingStatus.loaded;

  bool get hasFeeBreakdown =>
      feeBreakdown != null && feeCalculationStatus == LoadingStatus.loaded;

  bool get hasError => errorMessage != null;

  bool get hasSuccess => successMessage != null;

  // Check if any operation is loading
  bool get isAnyLoading =>
      isCartLoading ||
      isLocationLoading ||
      isFreightQuoteLoading ||
      isShippingSelectionLoading ||
      isInsuranceLoading ||
      isInsuranceConfirmationLoading ||
      isFeeCalculationLoading;
}

final class CartShippingInitial extends CartShippingState {
  const CartShippingInitial() : super();
}

class FeeBreakdown {
  final double goodsValue;
  final double platformFees;
  final double localTransitFees;
  final double exportFreightPackingOtherFees;
  final double destDutyTaxesOtherFees;
  final double transitInsurance;
  final double estimatedTotal;

  const FeeBreakdown({
    required this.goodsValue,
    required this.platformFees,
    required this.localTransitFees,
    required this.exportFreightPackingOtherFees,
    required this.destDutyTaxesOtherFees,
    required this.transitInsurance,
    required this.estimatedTotal,
  });

  FeeBreakdown copyWith({
    double? goodsValue,
    double? platformFees,
    double? localTransitFees,
    double? exportFreightPackingOtherFees,
    double? destDutyTaxesOtherFees,
    double? transitInsurance,
    double? estimatedTotal,
  }) {
    return FeeBreakdown(
      goodsValue: goodsValue ?? this.goodsValue,
      platformFees: platformFees ?? this.platformFees,
      localTransitFees: localTransitFees ?? this.localTransitFees,
      exportFreightPackingOtherFees:
          exportFreightPackingOtherFees ?? this.exportFreightPackingOtherFees,
      destDutyTaxesOtherFees:
          destDutyTaxesOtherFees ?? this.destDutyTaxesOtherFees,
      transitInsurance: transitInsurance ?? this.transitInsurance,
      estimatedTotal: estimatedTotal ?? this.estimatedTotal,
    );
  }

  // @override
  // String toString() {
  //   return 'FeeBreakdown(goodsValue: $goodsValue, platformFees: $platformFees, localTransitFees: $localTransitFees, exportFreightPackingOtherFees: $exportFreightPackingOtherFees, destDutyTaxesOtherFees: $destDutyTaxesOtherFees, transitInsurance: $transitInsurance, estimatedTotal: $estimatedTotal)';
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FeeBreakdown &&
        other.goodsValue == goodsValue &&
        other.platformFees == platformFees &&
        other.localTransitFees == localTransitFees &&
        other.exportFreightPackingOtherFees == exportFreightPackingOtherFees &&
        other.destDutyTaxesOtherFees == destDutyTaxesOtherFees &&
        other.transitInsurance == transitInsurance &&
        other.estimatedTotal == estimatedTotal;
  }

  @override
  int get hashCode {
    return goodsValue.hashCode ^
        platformFees.hashCode ^
        localTransitFees.hashCode ^
        exportFreightPackingOtherFees.hashCode ^
        destDutyTaxesOtherFees.hashCode ^
        transitInsurance.hashCode ^
        estimatedTotal.hashCode;
  }
}
