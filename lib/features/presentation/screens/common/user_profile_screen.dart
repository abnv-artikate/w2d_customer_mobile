import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/user_profile_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            UserProfileWidget(),
            SizedBox(height: 30),
            Text(
              'User Name',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            // _profileListItem(title: 'Profile',onItemTap: () {}, iconData: LucideIcons.user),
            // Divider(),
            _profileListItem(
              title: 'Wishlist',
              onItemTap: () {},
              iconData: LucideIcons.heart,
            ),
            Divider(),
            _profileListItem(
              title: 'Orders',
              onItemTap: () {
                context.push(AppRoutes.orderRoute);
              },
              iconData: LucideIcons.package,
            ),
            Divider(),
            _profileListItem(
              title: 'Logout',
              onItemTap: () {
                _callLogoutApi();
                context.go(AppRoutes.initial);
              },
              iconData: LucideIcons.logOut,
            ),
          ],
        ),
      ),
    );
  }

  _profileListItem({
    required String title,
    required VoidCallback onItemTap,
    required IconData iconData,
  }) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(iconData),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void _callLogoutApi() {
    context.read<CommonCubit>().logout();
  }
}
