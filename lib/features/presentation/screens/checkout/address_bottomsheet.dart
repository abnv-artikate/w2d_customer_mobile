import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_text_field.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
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

  String countryCode = "";

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

              countryCode = placemarks[0].isoCountryCode!;
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
            title: "Save Address",
            color: AppColors.worldGreen,
            height: 50,
            width: MediaQuery.of(context).size.width,
            onTap: () {
              _callSaveAddressApi(
                CreateAddressParams(
                  fullName: "${_firstNameCtrl.text} ${_lastNameCtrl.text}",
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
  }

  // void _clearTextFields() {
  //   _firstNameCtrl.clear();
  //   _lastNameCtrl.clear();
  //   _primaryPhoneCtrl.clear();
  //   _emailCtrl.clear();
  //   _streetCtrl.clear();
  //   _completeAddCtrl.clear();
  //   _cityCtrl.clear();
  //   _pinCtrl.clear();
  // }

  void _callSaveAddressApi(CreateAddressParams params) {
    context.read<AddressCubit>().saveAddress(params);
  }
}
