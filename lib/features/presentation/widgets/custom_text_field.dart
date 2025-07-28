import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController ctrl;
  final FocusNode focusNode;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final String hintText;
  final TapRegionCallback onTapOutside;
  final TextInputType textInputType;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.ctrl,
    required this.focusNode,
    this.enabledBorderColor = AppColors.softWhite71,
    this.focusedBorderColor = AppColors.worldGreen,
    this.textInputType = TextInputType.text,
    required this.hintText,
    required this.onTapOutside,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      controller: widget.ctrl,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.enabledBorderColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.softWhite80,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      // cursorColor: AppColors.deepBlue,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      maxLength: widget.maxLength,
      onTapOutside: widget.onTapOutside,
    );
  }
}
