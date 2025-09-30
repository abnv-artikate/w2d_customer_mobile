import 'package:flutter/material.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  final Widget title;
  final Color color;
  final double fontSize;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final double verticalMargin;
  final double horizontalMargin;
  final double height;
  final double? width;
  final VoidCallback onTap;

  const CustomFilledButtonWidget({
    super.key,
    required this.title,
    required this.color,
    required this.height,
    required this.onTap,
    this.width,
    this.fontSize = 24,
    this.borderRadius = 100,
    this.verticalPadding = 4,
    this.horizontalPadding = 4,
    this.verticalMargin = 1,
    this.horizontalMargin = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(
          vertical: verticalMargin,
          horizontal: horizontalMargin,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          border: Border.all(color: color),
        ),
        child: Center(
          child: title,
        ),
      ),
    );
  }
}
