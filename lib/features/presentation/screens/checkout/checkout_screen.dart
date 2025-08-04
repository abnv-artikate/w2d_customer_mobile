import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/order_success_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/pending_order_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/payment/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/orders/orders_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_text_field.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_breakdown_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class CheckoutScreen extends StatefulWidget {
  final CheckOutScreenEntity checkOutScreenEntity;

  const CheckoutScreen({super.key, required this.checkOutScreenEntity});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _primaryPhoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _completeAddCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _pinCtrl = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _primaryPhoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _completeAddNode = FocusNode();
  final FocusNode _pinNode = FocusNode();

  bool? isTransitInsured;
  String countryCode = "";

  // int? selectedAdd;
  CustomerAddressesEntity? selectedAdd;

  List<CustomerAddressesEntity> addressList = [];

  @override
  initState() {
    _callGetSavedAddressApi();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _primaryPhoneCtrl.dispose();
    _emailCtrl.dispose();
    _streetCtrl.dispose();
    _completeAddCtrl.dispose();
    _cityCtrl.dispose();
    _pinCtrl.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _primaryPhoneNode.dispose();
    _emailNode.dispose();
    _streetNode.dispose();
    _completeAddNode.dispose();
    _pinNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Screen")),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is InitiatePaymentLoaded) {
                _callPendingOrderApi(response: state.response);
              } else if (state is InitiatePaymentError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is VerifyPaymentLoaded) {
                if (state.response.status == 'A') {
                  _callOrderSuccessApi(
                    OrderSuccessParams(
                      paymentReference: state.paymentRef,
                      gatewayTxnId: state.response.tranRef,
                      cartId: widget.checkOutScreenEntity.cartSessionKey,
                    ),
                  );
                } else {
                  widget.showErrorToast(
                    context: context,
                    message: state.response.message,
                  );
                }
              } else if (state is VerifyPaymentError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is OrderPendingLoaded) {
                context
                    .push(AppRoutes.paymentRoute, extra: state.startUrl)
                    .then((_) {
                      _callConfirmPaymentApi(state.transactionCode);
                    });
                widget.showErrorToast(
                  context: context,
                  message: "Order Pending Created",
                );
              } else if (state is OrderPendingError) {
                widget.showErrorToast(
                  context: context,
                  message: "Error while creating order",
                );
              }

              if (state is OrderSuccessLoaded) {
                context.pop();
              } else if (state is OrderSuccessError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {
                    if (state is GetSavedAddressLoaded) {
                      addressList = state.list;
                      selectedAdd = state.defaultAdd;
                    } else if (state is GetSavedAddressError) {
                      widget.showErrorToast(
                        context: context,
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return _savedAddress();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: BlankButtonWidget(
                    title: "Add Address",
                    width: (MediaQuery.of(context).size.width * 0.5),
                    height: 50,
                    borderRadius: 4,
                    onTap: () {
                      _addNewAddress();
                    },
                  ),
                ),
                ShippingBreakdownWidget(
                  cartItems: widget.checkOutScreenEntity.cartItems,
                  location: null,
                  freightQuoteEntityData: null,
                  calculateInsuranceEntity:
                      widget.checkOutScreenEntity.calculateInsuranceEntity,
                  isTransitInsured:
                      isTransitInsured != null
                          ? isTransitInsured!
                          : widget.checkOutScreenEntity.isTransitInsured,
                  onShippingMethodDropdownTap: () {},
                  onTransitInsuranceTap: (bool? value) {
                    setState(() {
                      isTransitInsured = value!;
                    });
                    if (isTransitInsured != null) {
                      _callConfirmInsuranceApi(
                        quoteToken:
                            widget
                                .checkOutScreenEntity
                                .freightQuoteEntityData!
                                .quoteToken,
                        addInsurance: isTransitInsured!,
                      );
                    }
                  },
                ),
                SizedBox(height: 5),
                CustomFilledButtonWidget(
                  title: "Proceed",
                  color: AppColors.worldGreen,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  onTap: () {
                    _callInitiatePaymentApi(
                      PaymentRequestEntity(
                        cartId: widget.checkOutScreenEntity.cartSessionKey,
                        amount: '1000',
                        currency: 'AED',
                        firstName: selectedAdd?.fullName ?? "",
                        lastName: "",
                        street: selectedAdd?.addressLine1 ?? "",
                        city: selectedAdd?.city ?? "",
                        region: "",
                        country: selectedAdd?.country ?? "",
                        zip: "",
                        email: "",
                        phone: selectedAdd?.primaryPhoneNumber ?? "",
                      ),
                    );
                    // _clearTextFields();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addNewAddress() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 1,
      builder: (BuildContext context) {
        return BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is CreateAddressLoaded) {
              _callGetSavedAddressApi();
              context.pop();
            } else if (state is CreateAddressError) {
              widget.showErrorToast(context: context, message: state.error);
            }
          },
          builder: (context, state) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Receiver Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      CustomTextField(
                        ctrl: _firstNameCtrl,
                        hintText: 'First Name',
                        focusNode: _firstNameNode,
                        onTapOutside: (_) {
                          _firstNameNode.unfocus();
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        ctrl: _lastNameCtrl,
                        hintText: 'Last Name',
                        focusNode: _lastNameNode,
                        onTapOutside: (_) {
                          _lastNameNode.unfocus();
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        ctrl: _primaryPhoneCtrl,
                        hintText: 'Primary Phone Number',
                        textInputType: TextInputType.number,
                        focusNode: _primaryPhoneNode,
                        onTapOutside: (_) {
                          _primaryPhoneNode.unfocus();
                        },
                        maxLength: 10,
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        ctrl: _emailCtrl,
                        hintText: 'Email Address',
                        focusNode: _emailNode,
                        onTapOutside: (_) {
                          _emailNode.unfocus();
                        },
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        ctrl: _streetCtrl,
                        hintText: 'Street',
                        focusNode: _streetNode,
                        onTapOutside: (_) {
                          _streetNode.unfocus();
                        },
                      ),
                      SizedBox(height: 5),
                      GooglePlaceAutoCompleteTextField(
                        textEditingController: _completeAddCtrl,
                        focusNode: _completeAddNode,
                        googleAPIKey: "AIzaSyCBixn2iS2Fm7jDolWu4S5dBqA1avQ7T_g",
                        boxDecoration: BoxDecoration(),
                        inputDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.softWhite71,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.worldGreen,
                              width: 2,
                            ),
                          ),
                          hintText: 'Complete Address',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.softWhite80,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                        ),
                        debounceTime: 800,
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (
                          Prediction prediction,
                        ) async {
                          double lat = double.parse(prediction.lat!);
                          double lng = double.parse(prediction.lng!);
                          _cityCtrl.text = prediction.terms?.first.value ?? "";
                          final List<Placemark> placemarks =
                              await placemarkFromCoordinates(lat, lng);

                          countryCode = placemarks[0].isoCountryCode!;
                        },

                        itemClick: (Prediction prediction) {
                          _completeAddCtrl.text = prediction.description!;
                          _completeAddCtrl
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: prediction.description!.length,
                            ),
                          );
                        },
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 7),
                                Expanded(
                                  child: Text(prediction.description ?? ""),
                                ),
                              ],
                            ),
                          );
                        },
                        seperatedBuilder: Divider(),
                        isCrossBtnShown: true,
                        containerHorizontalPadding: 0,
                        placeType: PlaceType.geocode,
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        ctrl: _pinCtrl,
                        hintText: 'Pin',
                        focusNode: _pinNode,
                        onTapOutside: (_) {
                          _pinNode.unfocus();
                        },
                      ),
                      SizedBox(height: 5),
                      CustomFilledButtonWidget(
                        title: "Save Address",
                        color: AppColors.worldGreen,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          _callSaveAddressApi(
                            CreateAddressParams(
                              fullName:
                                  _firstNameCtrl.text + _lastNameCtrl.text,
                              primaryPhone: _primaryPhoneCtrl.text,
                              secondaryPhone: "",
                              addLine1: _streetCtrl.text,
                              addLine2: "",
                              city: _cityCtrl.text,
                              latitude: "",
                              longitude: "",
                              country: countryCode,
                              isDefault: false,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  _savedAddress() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedAdd = addressList[index];
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // border: Border.all(color: AppColors.deepBlue),
              boxShadow: [
                BoxShadow(
                  color:
                      selectedAdd?.id == addressList[index].id
                          ? AppColors.worldGreen
                          : AppColors.deepBlue,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Address Id: ${addressList[index].id.toString()}'),
                Text('Name: ${addressList[index].fullName}'),
                Text('Phone No: ${addressList[index].primaryPhoneNumber}'),
                Text('Address Type: ${addressList[index].addressType}'),
                Text(
                  'Address : ${addressList[index].addressLine1}, ${addressList[index].city}, ${addressList[index].country}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _callConfirmInsuranceApi({
    required String quoteToken,
    required bool addInsurance,
  }) {
    context.read<ShippingCubit>().confirmInsurance(
      ConfirmInsuranceParams(
        quoteToken: quoteToken,
        addInsurance: addInsurance,
      ),
    );
  }

  void _callInitiatePaymentApi(PaymentRequestEntity request) {
    context.read<PaymentCubit>().initiatePayment(request);
  }

  void _callConfirmPaymentApi(String transCode) {
    context.read<PaymentCubit>().verifyPayment(transCode);
  }

  void _clearTextFields() {
    _firstNameCtrl.clear();
    _lastNameCtrl.clear();
    _primaryPhoneCtrl.clear();
    _emailCtrl.clear();
    _streetCtrl.clear();
    _completeAddCtrl.clear();
    _cityCtrl.clear();
    _pinCtrl.clear();
  }

  void _callPendingOrderApi({required PaymentResponseEntity response}) {
    context.read<OrdersCubit>().pendingOrder(
      params: OrderPendingParams(
        cartId: widget.checkOutScreenEntity.cartSessionKey,
        addressId: 87,
        quoteToken:
            widget.checkOutScreenEntity.freightQuoteEntityData!.quoteToken,
        transitInsurance:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .insuranceAmt ??
            0,
        platformFee: 0,
        destinationDuty: 0,
        vat: 0,
        localTransitFee: widget.checkOutScreenEntity.localTransitFee,
        currency: "AED",
        shippingCost:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .freightAmount ??
            0,
        productPrice:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .goodsValue ??
            0,
        sumTotal:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .netTotal ??
            0,
        file: "",
        orderRef: response.transactionCode,
      ),
      startUrl: response.startUrl,
      transactionCode: response.transactionCode,
    );
  }

  void _callGetSavedAddressApi() {
    context.read<AddressCubit>().getSavedAddress();
  }

  void _callOrderSuccessApi(OrderSuccessParams params) {
    context.read<OrdersCubit>().orderSuccess(params);
  }

  void _callSaveAddressApi(CreateAddressParams params) {
    context.read<AddressCubit>().saveAddress(params);
  }
}

class CheckOutScreenEntity {
  final List<CartItemEntity> cartItems;
  FreightQuoteEntityData? freightQuoteEntityData;
  CalculateInsuranceEntity? calculateInsuranceEntity;
  double localTransitFee;
  final bool isTransitInsured;
  final String cartSessionKey;

  CheckOutScreenEntity({
    required this.cartItems,
    this.freightQuoteEntityData,
    this.calculateInsuranceEntity,
    required this.localTransitFee,
    required this.isTransitInsured,
    required this.cartSessionKey,
  });
}
