import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class ShippingMethodDropdownWidget extends StatelessWidget {
  final String shippingMethodText;
  final VoidCallback onTap;

  const ShippingMethodDropdownWidget({
    super.key,
    required this.shippingMethodText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.softWhite80,
        ),
        child: Row(
          children: [
            Icon(LucideIcons.chevronDown),
            SizedBox(width: 5),
            Text(
              shippingMethodText.isNotEmpty
                  ? shippingMethodText
                  : "Select Shipping Method",
            ),
          ],
        ),
      ),
    );
  }
}
