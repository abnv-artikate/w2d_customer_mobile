import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class SearchWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SearchWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.black70),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.softWhite71,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(LucideIcons.search, color: AppColors.black70,),
              SizedBox(width: 10),
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
