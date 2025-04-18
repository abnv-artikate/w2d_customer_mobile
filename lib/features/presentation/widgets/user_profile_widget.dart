import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  final String imgUrl =
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.worldGreen,
        child: CircleAvatar(
          radius: 15,
          foregroundImage: NetworkImage(imgUrl),
          backgroundImage: NetworkImage(imgUrl),
          backgroundColor: AppColors.softWhite80,
        ),
      ),
    );
  }
}
