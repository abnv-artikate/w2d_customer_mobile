import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class InputFormWidget extends StatefulWidget {
  final String title;
  final TextEditingController inputController;

  const InputFormWidget({
    super.key,
    required this.title,
    required this.inputController,
  });

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          style: TextStyle(color: AppColors.black),
          controller: widget.inputController,
        ),
      ],
    );
  }
}
