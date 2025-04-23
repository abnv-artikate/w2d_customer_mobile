import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/login_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cart_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/explore_categories_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/scaffold_with_nav.dart';
import 'package:w2d_customer_mobile/features/presentation/common/search_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/user_profile_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/home_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/product_screen.dart';
import 'package:w2d_customer_mobile/injection_container.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.initial,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNav(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.initial,
          builder: (BuildContext context, GoRouterState state) {
            return HomeScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.exploreRoute,
          builder: (BuildContext context, GoRouterState state) {
            return ExploreCategoriesScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.cartRoute,
          builder: (BuildContext context, GoRouterState state) {
            return CartScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.profileRoute,
          builder: (BuildContext context, GoRouterState state) {
            return UserProfileScreen();
          },
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.loginRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
          child: LoginScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.listingRoute,
      builder: (BuildContext context, GoRouterState state) {
        return CategoryListingScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.productRoute,
      builder: (BuildContext context, GoRouterState state) {
        return ProductScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.searchRoute,
      builder: (BuildContext context, GoRouterState state) {
        return SearchScreen();
      },
    ),
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   path: '/test',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return GeolocatorWidget();
    //   },
    // ),
  ],
);
