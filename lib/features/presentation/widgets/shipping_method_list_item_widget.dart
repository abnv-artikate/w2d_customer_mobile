import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';

class ShippingMethodListItemWidget extends StatefulWidget {
  const ShippingMethodListItemWidget({
    super.key,
    required this.label,
    required this.serviceType,
    required this.shippingFee,
    required this.transitEta,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String serviceType;
  final String shippingFee;
  final String transitEta;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<ShippingMethodListItemWidget> createState() =>
      _ShippingMethodListItemWidgetState();
}

class _ShippingMethodListItemWidgetState
    extends State<ShippingMethodListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.black),
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.isSelected,
              onChanged: (_) {},
              activeColor: AppColors.worldGreen,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Mode: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Service Type: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Shipping Fee : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Transit ETA: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  widget.serviceType,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                CurrencyWidget(
                  price: widget.shippingFee,
                  fontSize: 18,
                  strikeThrough: false,
                ),
                Text(
                  '${widget.transitEta} days',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
