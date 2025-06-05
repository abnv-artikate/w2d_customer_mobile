import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/login_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/checkout/checkout_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cart_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/explore_categories_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/scaffold_with_nav.dart';
import 'package:w2d_customer_mobile/features/presentation/common/search_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/user_profile_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/common/home_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/product_screen.dart';
import 'package:w2d_customer_mobile/injection_container.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.checkoutRoute,
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
            return MultiBlocProvider(
              providers: [
                BlocProvider<CategoryCubit>(
                  create: (context) => sl<CategoryCubit>(),
                ),
                BlocProvider<CommonCubit>(
                  create: (context) => sl<CommonCubit>(),
                ),
              ],
              child: HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.exploreRoute,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider<CommonCubit>(
              create: (context) => sl<CommonCubit>(),
              child: ExploreCategoriesScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.cartRoute,
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<CartCubit>(create: (context) => sl<CartCubit>()),
                BlocProvider<ShippingCubit>(
                  create: (context) => sl<ShippingCubit>(),
                ),
              ],
              child: CartScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.profileRoute,
          builder: (BuildContext context, GoRouterState state) {
            final bloc = BlocProvider.of<CommonCubit>(context);

            if (bloc.isUserLoggedIn()) {
              return UserProfileScreen();
            } else {
              return LoginScreen();
            }
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
        return BlocProvider<CategoryCubit>(
          create: (context) => sl<CategoryCubit>(),
          child: CategoryListingScreen(categorySlug: state.extra as String),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.productRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<CategoryCubit>(
          create: (context) => sl<CategoryCubit>(),
          child: ProductScreen(productEntity: state.extra as ProductViewEntity),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.searchRoute,
      builder: (BuildContext context, GoRouterState state) {
        return SearchScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.checkoutRoute,
      builder: (BuildContext context, GoRouterState state) {
        return CheckoutScreen();
      },
    ),
  ],
);
