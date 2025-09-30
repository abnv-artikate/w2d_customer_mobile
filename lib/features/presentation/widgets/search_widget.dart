import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class SearchWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SearchWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.black70),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.softWhite71,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                Assets.iconsW2DLogoGreen,
                width: 40,
                height: 40,
                color: AppColors.black70,
              ),
              SizedBox(width: 15),
              Icon(LucideIcons.search, color: AppColors.black70),
              SizedBox(width: 5),
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
