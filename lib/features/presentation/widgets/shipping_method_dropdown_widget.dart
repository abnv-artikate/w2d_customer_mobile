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
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.softWhite80,
        ),
        child: Row(
          children: [
            Icon(LucideIcons.chevronDown),
            Text(
              shippingMethodText.isNotEmpty
                  ? shippingMethodText
                  : "Select shipping method",
            ),
          ],
        ),
      ),
    );
  }
}
