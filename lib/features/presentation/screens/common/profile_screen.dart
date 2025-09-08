import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _profileListItem(
              title: 'Profile',
              onItemTap: () {
                context.push(AppRoutes.userProfileRoute);
              },
              iconData: LucideIcons.user2,
            ),
            Divider(),
            _profileListItem(
              title: 'Wishlist',
              onItemTap: () {
                context.push(AppRoutes.wishlistRoute);
              },
              iconData: LucideIcons.heart,
            ),
            Divider(),
            _profileListItem(
              title: 'Addresses',
              onItemTap: () {
                context.push(AppRoutes.addressRoute);
              },
              iconData: LucideIcons.mapPin,
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
                context.read<CommonCubit>().logout();
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
}
