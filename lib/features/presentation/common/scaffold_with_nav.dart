import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

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
        shadowColor: AppColors.softWhite80,
        indicatorColor: AppColors.softWhite71,
        selectedIndex: navBarIndex,
        destinations: <Widget>[
          CustomNavigationDestination(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
          ),
          CustomNavigationDestination(
            icon:
                navBarIndex == 1
                    ? Image.asset(
                      Assets.iconsBrandMallActive,
                      height: 30,
                      width: 30,
                    )
                    : Image.asset(
                      Assets.iconsBrandMallInactive,
                      height: 30,
                      width: 30,
                    ),
            label: 'Brand Mall',
          ),
          CustomNavigationDestination(
            icon:
                navBarIndex == 2
                    ? Image.asset(
                      Assets.iconsHiddenGemsActive,
                      height: 30,
                      width: 30,
                    )
                    : Image.asset(
                      Assets.iconsHiddenGemsInactive,
                      height: 30,
                      width: 30,
                    ),
            label: 'Hidden Gems',
          ),
          CustomNavigationDestination(
            icon: Icon(Icons.person_2_outlined, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _goToScreen(int index) {
    List<String> screens = [
      AppRoutes.homeRoute,
      AppRoutes.listingRoute,
      AppRoutes.listingRoute,
      AppRoutes.listingRoute,
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
