import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class BrandMallToggleWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool isBrand;

  const BrandMallToggleWidget({
    super.key,
    required this.onTap,
    required this.isBrand,
  });

  @override
  State<BrandMallToggleWidget> createState() => _BrandMallToggleWidgetState();
}

class _BrandMallToggleWidgetState extends State<BrandMallToggleWidget> {
  Duration animationDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: animationDuration,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 10),
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          gradient:
              widget.isBrand
                  ? AppColors.aspirationGold
                  : AppColors.worldGreenGradiant,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),

        child: AnimatedAlign(
          duration: animationDuration,
          alignment:
              widget.isBrand ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              padding: EdgeInsets.all(4),
              // height: 30,
              // width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Image.asset(
                widget.isBrand
                    ? Assets.iconsBrandMallActive
                    : Assets.iconsHiddenGemsActive,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
