import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    super.key,
    required this.price,
    required this.fontSize,
    required this.strikeThrough,
    this.fontColor = AppColors.deepBlue,
    this.strikeThroughColor = AppColors.black,
    this.svgHeight = 10,
    this.svgWidth = 5,
  });

  final String price;
  final double fontSize;
  final bool strikeThrough;
  final Color? fontColor;
  final Color? strikeThroughColor;
  final double svgHeight;
  final double svgWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!strikeThrough) ...[
          SvgPicture.asset(
            Assets.iconsUAEDirhamSymbol,
            height: svgHeight,
            width: svgWidth,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 4),
        ],
        Text(
          price,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor,
            decoration: strikeThrough ? TextDecoration.lineThrough : null,
            decorationColor: strikeThroughColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
