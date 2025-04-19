import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/user_profile_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.2),
            UserProfileWidget(),
            SizedBox(height: 30),
            Text(
              'mrxyzwithaverylongname@example.com',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
