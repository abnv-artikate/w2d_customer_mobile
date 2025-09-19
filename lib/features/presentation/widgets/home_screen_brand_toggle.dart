import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class HomeScreenBrandToggle extends StatelessWidget {
  const HomeScreenBrandToggle({
    super.key,
    required this.isBrand,
    required this.image,
    required this.text,
    required this.gradient,
    required this.borderColor,
  });

  final bool isBrand;
  final String image;
  final String text;
  final LinearGradient gradient;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.45,
      height: screenWidth * 0.15,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border:
            isBrand
                ? null
                : Border.all(
                  color: isBrand ? AppColors.transparent : borderColor,
                  width: 2,
                ),
        gradient: isBrand ? gradient : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 30,
            width: 30,
            color: isBrand ? AppColors.white : null,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isBrand ? AppColors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
