part of 'cart_shipping_cubit.dart';

enum LoadingStatus { initial, loading, loaded, error }

const _unset = Object();

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
  final ConfirmInsuranceEntityData? insuranceConfirm;
  final bool isTransitInsured;

  // Voucher related
  final LoadingStatus getVoucherStatus;
  final List<VouchersEntity>? vouchers;
  final LoadingStatus validateVoucherStatus;
  final ValidateVoucherEntity? validatedVoucher;
  final bool isVoucherApplied;

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
    this.insuranceConfirm,
    this.isTransitInsured = false,
    this.getVoucherStatus = LoadingStatus.initial,
    this.vouchers,
    this.validateVoucherStatus = LoadingStatus.initial,
    this.validatedVoucher,
    this.isVoucherApplied = false,
    this.feeCalculationStatus = LoadingStatus.initial,
    this.feeBreakdown,
    this.errorMessage,
    this.successMessage,
  });

  CartShippingState copyWith({
    LoadingStatus? cartStatus,
    Object? cart = _unset, // CartEntity?
    LoadingStatus? locationStatus,
    Object? location = _unset, // LocationEntity?
    LoadingStatus? freightQuoteStatus,
    Object? freightQuote = _unset, // FreightQuoteEntityData?
    LoadingStatus? shippingSelectionStatus,
    Object? selectedShippingIndex = _unset, // int?
    LoadingStatus? insuranceStatus,
    Object? insuranceData = _unset, // CalculateInsuranceEntity?
    LoadingStatus? insuranceConfirmationStatus,
    ConfirmInsuranceEntityData? insuranceConfirm,
    bool? isTransitInsured,
    LoadingStatus? getVoucherStatus,
    Object? vouchers, // List<VouchersEntity>?
    LoadingStatus? validateVoucherStatus,
    Object? validatedVoucher, // ValidateVoucherEntity
    bool? isVoucherApplied,
    LoadingStatus? feeCalculationStatus,
    Object? feeBreakdown = _unset, // FeeBreakdown?
    Object? errorMessage = _unset, // String?
    Object? successMessage = _unset, // String?
  }) {
    return CartShippingState(
      cartStatus: cartStatus ?? this.cartStatus,
      cart: identical(cart, _unset) ? this.cart : cart as CartEntity?,
      locationStatus: locationStatus ?? this.locationStatus,
      location:
          identical(location, _unset)
              ? this.location
              : location as LocationEntity?,
      freightQuoteStatus: freightQuoteStatus ?? this.freightQuoteStatus,
      freightQuote:
          identical(freightQuote, _unset)
              ? this.freightQuote
              : freightQuote as FreightQuoteEntityData?,
      shippingSelectionStatus:
          shippingSelectionStatus ?? this.shippingSelectionStatus,
      selectedShippingIndex:
          identical(selectedShippingIndex, _unset)
              ? this.selectedShippingIndex
              : selectedShippingIndex as int?,
      insuranceStatus: insuranceStatus ?? this.insuranceStatus,
      insuranceData:
          identical(insuranceData, _unset)
              ? this.insuranceData
              : insuranceData as CalculateInsuranceEntity?,
      insuranceConfirmationStatus:
          insuranceConfirmationStatus ?? this.insuranceConfirmationStatus,
      isTransitInsured: isTransitInsured ?? this.isTransitInsured,
      getVoucherStatus: getVoucherStatus ?? this.getVoucherStatus,
      vouchers:
          identical(vouchers, _unset)
              ? this.vouchers
              : vouchers as List<VouchersEntity>?,
      validateVoucherStatus:
          validateVoucherStatus ?? this.validateVoucherStatus,
      validatedVoucher:
          identical(validatedVoucher, _unset)
              ? this.validatedVoucher
              : validatedVoucher as ValidateVoucherEntity?,
      isVoucherApplied: isVoucherApplied ?? this.isVoucherApplied,
      feeCalculationStatus: feeCalculationStatus ?? this.feeCalculationStatus,
      feeBreakdown:
          identical(feeBreakdown, _unset)
              ? this.feeBreakdown
              : feeBreakdown as FeeBreakdown?,
      errorMessage:
          identical(errorMessage, _unset)
              ? this.errorMessage
              : errorMessage as String?,
      successMessage:
          identical(successMessage, _unset)
              ? this.successMessage
              : successMessage as String?,
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
