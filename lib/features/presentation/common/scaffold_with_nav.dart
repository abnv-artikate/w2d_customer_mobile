import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _goToScreen(index);
        },
        backgroundColor: AppColors.white,
        elevation: 0.6,
        shadowColor: AppColors.worldGreen10,
        indicatorColor: AppColors.worldGreen10,
        selectedIndex: navBarIndex,
        destinations: <Widget>[
          CustomNavigationDestination(
            icon: Icon(LucideIcons.home, size: 30),
            label: 'Home',
          ),
          CustomNavigationDestination(
            icon: Icon(LucideIcons.layoutPanelLeft, size: 30),
            label: 'Explore',
          ),

          CustomNavigationDestination(
            icon: Icon(LucideIcons.shoppingCart, size: 30),
            label: 'Cart',
          ),

          CustomNavigationDestination(
            icon: Icon(LucideIcons.user, size: 30),
            label: 'Profile',
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

class CustomNavigationDestination extends NavigationDestination {
  const CustomNavigationDestination({
    super.key,
    required super.icon,
    required super.label,
  });
}
