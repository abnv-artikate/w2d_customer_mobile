import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final double height;
  final double width;
  final VoidCallback onTap;

  const CustomFilledButtonWidget({
    super.key,
    required this.title,
    required this.color,
    required this.height,
    required this.width,
    required this.onTap,
    this.fontSize = 24,
    this.borderRadius = 100,
    this.verticalPadding = 4,
    this.horizontalPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          border: Border.all(color: color),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
