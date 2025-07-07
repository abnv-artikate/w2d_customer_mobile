import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/checkout/cubit/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
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
  bool addNewAdd = true;
  bool? isTransitInsured;
  String countryCode = "";

  @override
  initState() {
    super.initState();
  }

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _primaryPhoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _completeAddCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  // final TextEditingController _stateCtrl = TextEditingController();
  // final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _pinCtrl = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _primaryPhoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _completeAddNode = FocusNode();
  // final FocusNode _cityNode = FocusNode();
  // final FocusNode _stateNode = FocusNode();
  // final FocusNode _countryNode = FocusNode();
  final FocusNode _pinNode = FocusNode();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _primaryPhoneCtrl.dispose();
    _emailCtrl.dispose();
    _streetCtrl.dispose();
    _completeAddCtrl.dispose();
    _cityCtrl.dispose();
    // _stateCtrl.dispose();
    // _countryCtrl.dispose();
    _pinCtrl.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _primaryPhoneNode.dispose();
    _emailNode.dispose();
    _streetNode.dispose();
    _completeAddNode.dispose();
    // _cityNode.dispose();
    // _stateNode.dispose();
    // _countryNode.dispose();
    _pinNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Screen")),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is InitiatePaymentLoaded) {
            context
                .push(AppRoutes.paymentRoute, extra: state.response.startUrl)
                .then((_) {
                  _callConfirmPaymentApi(state.response.transactionCode);
                });
          } else if (state is InitiatePaymentError) {
            widget.showErrorToast(context: context, message: state.error);
          }

          if (state is VerifyPaymentLoaded) {
            widget.showErrorToast(context: context, message: state.message);
          } else if (state is VerifyPaymentError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   "Saved Addresses",
                //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                // ),
                // _savedAddress(),
                // _customerDetails(),
                // if (!addNewAdd) ...[
                //   BlankButtonWidget(
                //     title: "Add Address",
                //     width: (MediaQuery.of(context).size.width),
                //     height: 50,
                //     onTap: () {
                //       setState(() {
                //         addNewAdd = true;
                //       });
                //     },
                //   ),
                // ],
                ShippingBreakdownWidget(
                  location: null,
                  freightQuoteEntityData: null,
                  calculateInsuranceEntity:
                      widget.checkOutScreenEntity.calculateInsuranceEntity,
                  isTransitInsured:
                      isTransitInsured != null
                          ? isTransitInsured!
                          : widget.checkOutScreenEntity.isTransitInsured,
                  onShippingMethodDropdownTap: () {
                  },
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
                    ;
                  },
                ),
                if (addNewAdd) ...[_addNewAddress()],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addNewAddress() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Receiver Details",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
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
                borderSide: BorderSide(color: AppColors.softWhite71, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.worldGreen, width: 2),
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
            getPlaceDetailWithLatLng: (Prediction prediction) async {
              double lat = double.parse(prediction.lat!);
              double lng = double.parse(prediction.lng!);
              _cityCtrl.text = prediction.terms?.first.value ?? "";
              final List<Placemark> placemarks = await placemarkFromCoordinates(
                lat,
                lng,
              );
              countryCode = placemarks[1].isoCountryCode!;
            },
            itemClick: (Prediction prediction) {
              _completeAddCtrl.text = prediction.description!;
              _completeAddCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
            },
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 7),
                    Expanded(child: Text(prediction.description ?? "")),
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
            title: "Proceed",
            color: AppColors.worldGreen,
            height: 50,
            width: MediaQuery.of(context).size.width,
            onTap: () {
              _callInitiatePaymentApi(
                PaymentRequestEntity(
                  cartId: widget.checkOutScreenEntity.cartId,
                  amount: '1000',
                  currency: 'AED',
                  firstName: _firstNameCtrl.text,
                  lastName: _lastNameCtrl.text,
                  street: _streetCtrl.text,
                  city: _cityCtrl.text,
                  region: _cityCtrl.text,
                  country: countryCode,
                  zip: _pinCtrl.text,
                  email: _emailCtrl.text,
                  phone: _primaryPhoneCtrl.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // _customerDetails() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Customer Details",
  //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
  //         ),
  //         CustomTextField(
  //           ctrl: _firstNameCtrl,
  //           hintText: 'First Name',
  //           focusNode: _firstNameNode,
  //           onTapOutside: (_) {
  //             _firstNameNode.unfocus();
  //           },
  //         ),
  //         SizedBox(height: 5),
  //         CustomTextField(
  //           ctrl: _lastNameCtrl,
  //           hintText: 'Last Name',
  //           focusNode: _lastNameNode,
  //           onTapOutside: (_) {
  //             _lastNameNode.unfocus();
  //           },
  //         ),
  //         SizedBox(height: 5),
  //         CustomTextField(
  //           ctrl: _primaryPhoneCtrl,
  //           hintText: 'Primary Phone Number',
  //           focusNode: _primaryPhoneNode,
  //           onTapOutside: (_) {
  //             _primaryPhoneNode.unfocus();
  //           },
  //         ),
  //         SizedBox(height: 5),
  //         CustomTextField(
  //           ctrl: _emailCtrl,
  //           hintText: 'Email ID',
  //           focusNode: _emailNode,
  //           onTapOutside: (_) {
  //             _secondaryPhoneNode.unfocus();
  //           },
  //         ),
  //         SizedBox(height: 5),
  //         CustomFilledButtonWidget(
  //           title: 'Save for Future',
  //           color: AppColors.worldGreen,
  //           height: 50,
  //           width: (MediaQuery.of(context).size.width),
  //           onTap: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
}

class CheckOutScreenEntity {
  final String cartId;
  FreightQuoteEntityData? freightQuoteEntityData;
  CalculateInsuranceEntity? calculateInsuranceEntity;
  final bool isTransitInsured;

  CheckOutScreenEntity({
    required this.cartId,
    this.freightQuoteEntityData,
    this.calculateInsuranceEntity,
    required this.isTransitInsured,
  });
}
