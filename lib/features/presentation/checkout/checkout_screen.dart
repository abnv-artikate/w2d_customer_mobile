import 'package:flutter/material.dart';

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
              borderRadius: BorderRadius.circular(12),
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

  _customerDetails() {
    return Container();
  }

  _estimatedTotal() {
    return Container();
  }
}
