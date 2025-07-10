import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    super.key,
    required this.price,
    required this.fontSize,
    required this.strikeThrough,
    this.fontColor,
    this.strikeThroughColor,
  });

  final String price;
  final double fontSize;
  final bool strikeThrough;
  final Color? fontColor;
  final Color? strikeThroughColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Assets.iconsUAEDirhamSymbol,
          height: 10,
          width: 5,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 4),
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
