import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class BrandMallWidget extends StatefulWidget {
  const BrandMallWidget({super.key});

  @override
  State<BrandMallWidget> createState() => _BrandMallWidgetState();
}

class _BrandMallWidgetState extends State<BrandMallWidget> {
  bool isBrandMall = true;
  double fontSize = 20;
  double iconSize = 30;
  double borderWidth = 3;
  double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isBrandMall = true;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: isBrandMall ? 1500 : 500),
            curve: /*isBrandMall ? Curves.easeInBack : */Curves.decelerate,
            decoration: BoxDecoration(
              border: Border.all(
                width: isBrandMall ? borderWidth : borderWidth * 0.5,
                color:
                    isBrandMall ? AppColors.worldGreen : AppColors.softWhite80,
              ),
              borderRadius: BorderRadius.circular(
                isBrandMall ? borderRadius : borderRadius * 0.5,
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isBrandMall
                      ? Assets.iconsBrandMallActive
                      : Assets.iconsBrandMallInactive,
                  height: isBrandMall ? iconSize : iconSize * 0.5,
                  width: isBrandMall ? iconSize : iconSize * 0.5,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Brand Mall',
                      style: TextStyle(
                        fontSize: isBrandMall ? fontSize : fontSize * 0.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              isBrandMall = false;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: !isBrandMall ? 1500 : 500),
            curve: /*!isBrandMall ? Curves.easeInBack : */Curves.decelerate,
            decoration: BoxDecoration(
              border: Border.all(
                width: !isBrandMall ? borderWidth : borderWidth * 0.5,
                color:
                    !isBrandMall ? AppColors.worldGreen : AppColors.softWhite80,
              ),
              borderRadius: BorderRadius.circular(
                !isBrandMall ? borderRadius : borderRadius * 0.5,
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  !isBrandMall
                      ? Assets.iconsHiddenGemsActive
                      : Assets.iconsHiddenGemsInactive,
                  height: !isBrandMall ? iconSize : iconSize * 0.5,
                  width: !isBrandMall ? iconSize : iconSize * 0.5,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hidden Gems',
                      style: TextStyle(
                        fontSize: !isBrandMall ? fontSize : fontSize * 0.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
