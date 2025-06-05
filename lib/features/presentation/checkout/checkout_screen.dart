import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_text_field.dart';

class SavedAddress {
  final String id;
  final String firstName;
  final String lastName;
  final String city;
  final String state;

  SavedAddress({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
  });
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<SavedAddress> savedAddresses = [
    SavedAddress(
      id: "1",
      firstName: "Obi",
      lastName: "Wan",
      city: "Gurugram",
      state: "Haryana",
    ),
    SavedAddress(
      id: "2",
      firstName: "Obi",
      lastName: "Wan",
      city: "Gurugram",
      state: "Haryana",
    ),
    SavedAddress(
      id: "3",
      firstName: "Obi",
      lastName: "Wan",
      city: "Gurugram",
      state: "Haryana",
    ),
    SavedAddress(
      id: "4",
      firstName: "Obi",
      lastName: "Wan",
      city: "Gurugram",
      state: "Haryana",
    ),
  ];
  String? selectedAddressId;
  bool addNewAdd = false;

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _cityNameCtrl = TextEditingController();
  final TextEditingController _countryNameCtrl = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _cityNameNode = FocusNode();
  final FocusNode _countryNameNode = FocusNode();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _cityNameCtrl.dispose();
    _countryNameCtrl.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _cityNameNode.dispose();
    _countryNameNode.dispose();
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
              Text(
                "Saved Addresses",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
              _savedAddress(),
              if (!addNewAdd) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      addNewAdd = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(),
                    child: Text(
                      "+ Add Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),
              ],
              if (addNewAdd) ...[_addNewAddress()],
              _customerDetails(),
              _estimatedTotal(),
            ],
          ),
        ),
      ),
    );
  }

  _savedAddress() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: savedAddresses.length,
        itemBuilder: (context, index) {
          final address = savedAddresses[index];
          final isSelected = selectedAddressId == address.id;

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? Colors.blue.shade50 : Colors.white,
            ),
            child: RadioListTile<String>(
              value: address.id,
              groupValue: selectedAddressId,
              onChanged: (value) {
                setState(() {
                  selectedAddressId = value;
                });
              },
              title: Text(
                "${address.firstName} ${address.lastName}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(
                "${address.city}, ${address.state}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              activeColor: Colors.blue,
              contentPadding: const EdgeInsets.all(4),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 5);
        },
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
        ],
      ),
    );
  }

  _customerDetails() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details",
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
          CustomFilledButtonWidget(
            title: 'Save',
            color: AppColors.worldGreen,
            height: 50,
            width: (MediaQuery.of(context).size.width),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _estimatedTotal() {
    return Container();
  }
}
