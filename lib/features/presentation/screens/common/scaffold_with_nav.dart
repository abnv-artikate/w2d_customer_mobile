import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class ScaffoldWithNav extends StatefulWidget {
  final Widget child;

  const ScaffoldWithNav({super.key, required this.child});

  @override
  State<ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends State<ScaffoldWithNav> {
  int navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: _customNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _customNavigationBar() {
    final double iconSize = 25;
    final Color iconColor = AppColors.black70;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softWhite80, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: NavigationBar(
        height: 60,
        onDestinationSelected: (int index) {
          _goToScreen(index);
        },
        backgroundColor: AppColors.transparent,
        elevation: 0.6,
        indicatorColor: AppColors.worldGreen10,
        selectedIndex: navBarIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: <Widget>[
          NavigationDestination(
            label: "",
            icon: Icon(LucideIcons.home, size: iconSize, color: iconColor),
          ),
          NavigationDestination(
            label: "",
            icon: Icon(
              Icons.manage_search_outlined,
              size: iconSize,
              color: iconColor,
            ),
          ),
          NavigationDestination(
            label: "",
            icon: Icon(
              LucideIcons.shoppingCart,
              size: iconSize,
              color: iconColor,
            ),
          ),
          NavigationDestination(
            label: "",
            icon: Icon(LucideIcons.user, size: iconSize, color: iconColor),
          ),
        ],
      ),
    );
  }

  void _goToScreen(int index) {
    List<String> screens = [
      AppRoutes.initial,
      AppRoutes.exploreRoute,
      AppRoutes.cartRoute,
      AppRoutes.profileRoute,
    ];

    setState(() {
      navBarIndex = index;
      context.go(screens[index]);
    });
  }
}
