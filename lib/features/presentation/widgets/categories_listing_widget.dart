import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class CategoriesListingWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CategoriesListingWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.width * 0.2,
        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.deepBlue),
          // color: AppColors.worldGreen,
        ),
        child: Center(
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: AppColors.deepBlue,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
