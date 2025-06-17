import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_text_field.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_breakdown_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final CheckOutScreenEntity checkOutScreenEntity;

  const CheckoutScreen({super.key, required this.checkOutScreenEntity});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // String? selectedAddressId;
  bool addNewAdd = true;
  int? selectedShippingIndex;
  bool? isTransitInsured;

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _primaryPhoneCtrl = TextEditingController();
  final TextEditingController _secondaryPhoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _completeAddCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _pinCtrl = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _primaryPhoneNode = FocusNode();
  final FocusNode _secondaryPhoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _completeAddNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _stateNode = FocusNode();
  final FocusNode _countryNode = FocusNode();
  final FocusNode _pinNode = FocusNode();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _primaryPhoneCtrl.dispose();
    _secondaryPhoneCtrl.dispose();
    _emailCtrl.dispose();
    _completeAddCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _countryCtrl.dispose();
    _pinCtrl.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _primaryPhoneNode.dispose();
    _secondaryPhoneNode.dispose();
    _emailNode.dispose();
    _completeAddNode.dispose();
    _cityNode.dispose();
    _stateNode.dispose();
    _countryNode.dispose();
    _pinNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Screen")),
      body: SingleChildScrollView(
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
              if (addNewAdd) ...[_addNewAddress()],
              ShippingBreakdownWidget(
                cartItems: widget.checkOutScreenEntity.cartItems,
                location: null,
                freightQuoteEntityData: null,
                calculateInsuranceEntity:
                    widget.checkOutScreenEntity.calculateInsuranceEntity,
                selectedShippingIndex: selectedShippingIndex,
                isTransitInsured:
                    isTransitInsured != null
                        ? isTransitInsured!
                        : widget.checkOutScreenEntity.isTransitInsured,
                onShippingMethodDropdownTap: () {
                  // if (widget.freightQuoteEntityData) {
                  //   _shippingMethodBottomSheet();
                  // } else {
                  //   _callGetFreightQuoteApi(
                  //     cartItems: widget.cartItems,
                  //     address: widget.location,
                  //   );
                  // }
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
            ],
          ),
        ),
      ),
    );
  }

  // _savedAddress() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
  //     child: ListView.separated(
  //       shrinkWrap: true,
  //       itemCount: savedAddresses.length,
  //       itemBuilder: (context, index) {
  //         final address = savedAddresses[index];
  //         final isSelected = selectedAddressId == address.id;
  //
  //         return Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: isSelected ? Colors.blue : Colors.grey.shade300,
  //               width: isSelected ? 2 : 1,
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //             color: isSelected ? Colors.blue.shade50 : Colors.white,
  //           ),
  //           child: RadioListTile<String>(
  //             value: address.id,
  //             groupValue: selectedAddressId,
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedAddressId = value;
  //               });
  //             },
  //             title: Text(
  //               "${address.firstName} ${address.lastName}",
  //               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //             ),
  //             subtitle: Text(
  //               "${address.city}, ${address.state}",
  //               style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
  //             ),
  //             activeColor: Colors.blue,
  //             contentPadding: const EdgeInsets.all(4),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (BuildContext context, int index) {
  //         return SizedBox(height: 5);
  //       },
  //     ),
  //   );
  // }

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
            focusNode: _primaryPhoneNode,
            onTapOutside: (_) {
              _primaryPhoneNode.unfocus();
            },
          ),
          SizedBox(height: 5),
          CustomTextField(
            ctrl: _secondaryPhoneCtrl,
            hintText: 'Secondary Phone Number',
            focusNode: _secondaryPhoneNode,
            onTapOutside: (_) {
              _secondaryPhoneNode.unfocus();
            },
          ),
          SizedBox(height: 5),
          // CustomTextField(
          //   ctrl: _completeAddCtrl,
          //   hintText: 'Complete Address',
          //   focusNode: _completeAddNode,
          //   onTapOutside: (_) {
          //     _completeAddNode.unfocus();
          //   },
          // ),
          GooglePlaceAutoCompleteTextField(
            textEditingController: _completeAddCtrl,
            googleAPIKey: "AIzaSyCBixn2iS2Fm7jDolWu4S5dBqA1avQ7T_g",
            inputDecoration: InputDecoration(
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   borderSide: BorderSide(color: AppColors.softWhite71, width: 2),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   borderSide: BorderSide(color: AppColors.worldGreen, width: 2),
              // ),
              // hintText: 'Complete Address',
              // hintStyle: TextStyle(
              //   fontSize: 18,
              //   fontWeight: FontWeight.w400,
              //   color: AppColors.softWhite80,
              // ),
              // contentPadding: EdgeInsets.symmetric(
              //   horizontal: 22,
              //   vertical: 16,
              // ),
            ),
            debounceTime: 800,
            // default 600 ms,
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails " + prediction.lng.toString());
            },
            // this callback is called when isLatLngRequired is true
            itemClick: (Prediction prediction) {
              _completeAddCtrl.text = prediction.description!;
              _completeAddCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
            },
            // if we want to make custom list item builder
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
            // if you want to add seperator between list items
            seperatedBuilder: Divider(),
            // want to show close icon
            isCrossBtnShown: true,
            // optional container padding
            containerHorizontalPadding: 10,
            // place type
            placeType: PlaceType.geocode,
          ),
          SizedBox(height: 5),
          CustomTextField(
            ctrl: _cityCtrl,
            hintText: 'City',
            focusNode: _cityNode,
            onTapOutside: (_) {
              _cityNode.unfocus();
            },
          ),
          SizedBox(height: 5),
          CustomTextField(
            ctrl: _stateCtrl,
            hintText: 'State',
            focusNode: _stateNode,
            onTapOutside: (_) {
              _stateNode.unfocus();
            },
          ),
          SizedBox(height: 5),
          CustomTextField(
            ctrl: _countryCtrl,
            hintText: 'Country',
            focusNode: _countryNode,
            onTapOutside: (_) {
              _countryNode.unfocus();
            },
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

  // void _callGetFreightQuoteApi({
  //   required List<CartItemEntity> cartItems,
  //   required LocationEntity address,
  // }) {
  //   List<Items?> items =
  //       cartItems.map((e) {
  //         if (e.isChecked) {
  //           return Items(
  //             itemsGoods:
  //                 "${double.parse(e.product.regularPrice) * e.quantity}",
  //             itemDescription: e.product.productType,
  //             noOfPkgs: e.product.packagingDetails.length,
  //             attribute:
  //                 e.product.isCosmetics
  //                     ? "cosmetics"
  //                     : e.product.isPerfume
  //                     ? "perfumes"
  //                     : e.product.containsBattery
  //                     ? "battery"
  //                     : e.product.containsMagnet
  //                     ? "magnet"
  //                     : "",
  //             hsCode: e.product.hsCode,
  //             dimensions:
  //                 e.product.woodenBoxPackaging
  //                     ? e.product.packagingDetails.map((e) {
  //                       if (double.parse(e.weight.value) != 0.0 &&
  //                           double.parse(e.width.value) != 0.0 &&
  //                           double.parse(e.height.value) != 0.0 &&
  //                           double.parse(e.length.value) != 0.0) {
  //                         return Dimensions(
  //                           kiloGrams: double.parse(e.weight.value),
  //                           length: double.parse(e.length.value),
  //                           width: double.parse(e.width.value),
  //                           height: double.parse(e.height.value),
  //                           addWoodenPacking: true,
  //                         );
  //                       }
  //                     }).toList()
  //                     : e.product.packagingDetails.map((e) {
  //                       if (double.parse(e.weight.value) != 0.0 &&
  //                           double.parse(e.width.value) != 0.0 &&
  //                           double.parse(e.height.value) != 0.0 &&
  //                           double.parse(e.length.value) != 0.0) {
  //                         return Dimensions(
  //                           kiloGrams: double.parse(e.weight.value),
  //                           length: double.parse(e.length.value),
  //                           width: double.parse(e.width.value),
  //                           height: double.parse(e.height.value),
  //                           addWoodenPacking: false,
  //                         );
  //                       }
  //                     }).toList(),
  //           );
  //         }
  //       }).toList();
  //   if (items.isNotEmpty && items.nonNulls.toList().isNotEmpty) {
  //     context.read<ShippingCubit>().getFreightQuote(
  //       GetFreightQuoteParams(
  //         destinationCountry: address.country,
  //         destinationCountryShortName: address.isoCountryCode,
  //         destinationCity: address.city,
  //         destinationLatitude: address.latitude,
  //         destinationLongitude: address.longitude,
  //         items: items,
  //       ),
  //     );
  //   }
  // }
  //
  // void _callSelectFreightServiceApi(String quoteToken) {
  //   context.read<ShippingCubit>().selectFreightService(
  //     SelectFreightServiceParams(
  //       quoteToken: quoteToken,
  //       selectedCourierType: _getCourierType(selectedShippingIndex),
  //     ),
  //   );
  // }
  //
  // String _getCourierType(int? shippingIndex) {
  //   switch (shippingIndex) {
  //     case 0:
  //       return "DOORCOURIER";
  //     case 1:
  //       return "DOORAIR";
  //     case 2:
  //       return "PORTAIR";
  //     case 3:
  //       return "DOORSEA";
  //     case 4:
  //       return "PORTSEA";
  //     case 5:
  //       return "DOORLAND";
  //     default:
  //       return "";
  //   }
  // }
  //
  // void _callCalculateInsuranceApi(String quoteToken) {
  //   context.read<ShippingCubit>().calculateInsurance(
  //     CalculateInsuranceParams(quoteToken: quoteToken),
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
}

class CheckOutScreenEntity {
  final List<CartItemEntity> cartItems;

  // final LocationEntity location;
  FreightQuoteEntityData? freightQuoteEntityData;
  CalculateInsuranceEntity? calculateInsuranceEntity;
  final bool isTransitInsured;

  CheckOutScreenEntity({
    required this.cartItems,
    // required this.location,
    this.freightQuoteEntityData,
    this.calculateInsuranceEntity,
    required this.isTransitInsured,
  });
}
