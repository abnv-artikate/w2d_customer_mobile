import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class BlankButtonWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final double verticalMargin;
  final double horizontalMargin;
  final double height;
  final double? width;
  final VoidCallback onTap;

  const BlankButtonWidget({
    super.key,
    required this.title,
    required this.height,
    required this.onTap,
    this.width,
    this.fontSize = 24,
    this.borderRadius = 8,
    this.verticalPadding = 4,
    this.horizontalPadding = 4,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
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
        margin: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.black),
          color: AppColors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
