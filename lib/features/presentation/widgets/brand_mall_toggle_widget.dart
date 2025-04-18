import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class BrandMallToggleWidget extends StatefulWidget {
  const BrandMallToggleWidget({super.key});

  @override
  State<BrandMallToggleWidget> createState() => _BrandMallToggleWidgetState();
}

class _BrandMallToggleWidgetState extends State<BrandMallToggleWidget> {
  bool isBrand = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isBrand = !isBrand;
          });
        },
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient:
                    isBrand
                        ? AppColors.aspirationGold
                        : AppColors.worldGreenGradiant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    isBrand
                        ? Assets.iconsBrandMallInactive
                        : Assets.iconsHiddenGemsInactive,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                    color: AppColors.deepBlue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    isBrand ? 'Brand Mall' : 'Hidden Gems',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(4),
              color: AppColors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    isBrand
                        ? Assets.iconsHiddenGemsActive
                        : Assets.iconsBrandMallActive,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  // SizedBox(width: 5),
                  // Text(
                  //   'Brand Mall',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
