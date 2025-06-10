import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class CategoriesListingWidget extends StatelessWidget {
  final String name;
  final bool isExpanded;
  final VoidCallback? onTap;

  const CategoriesListingWidget({
    super.key,
    required this.name,
    required this.isExpanded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isExpanded ? AppColors.worldGreen : AppColors.deepBlue,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
