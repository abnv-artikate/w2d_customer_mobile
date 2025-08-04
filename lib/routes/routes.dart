import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/payment/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/orders/orders_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/auth/login_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/checkout/payment_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/cart_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/explore_categories_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/home_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/scaffold_with_nav.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/search_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/common/user_profile_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/marketplace/product_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/orders/order_screen.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
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
                BlocProvider<CartShippingCubit>(
                  create: (context) => sl<CartShippingCubit>(),
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
              return LoginScreen(isCheckout: false);
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
          child: LoginScreen(isCheckout: state.extra as bool),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.listingRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<CategoryCubit>(
          create: (context) => sl<CategoryCubit>(),
          child: CategoryListingScreen(
            category: state.extra as SubCategoriesEntity,
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.productRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<CategoryCubit>(
          create: (context) => sl<CategoryCubit>(),
          child: ProductScreen(product: state.extra as ProductViewEntity),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.searchRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<CategoryCubit>(
          create: (context) => sl<CategoryCubit>(),
          child: SearchScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.checkoutRoute,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ShippingCubit>(
              create: (context) => sl<ShippingCubit>(),
            ),
            BlocProvider<PaymentCubit>(create: (context) => sl<PaymentCubit>()),
            BlocProvider<OrdersCubit>(create: (context) => sl<OrdersCubit>()),
            BlocProvider<AddressCubit>(create: (context) => sl<AddressCubit>()),
            BlocProvider<CartCubit>(create: (context) => sl<CartCubit>()),
            BlocProvider<CartShippingCubit>(
              create: (context) => sl<CartShippingCubit>(),
            ),
            BlocProvider(create: (context) => sl<CommonCubit>()),
          ],
          child: CheckoutScreen(
            checkOutScreenEntity: state.extra as CheckOutScreenEntity,
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.paymentRoute,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ShippingCubit>(
              create: (context) => sl<ShippingCubit>(),
            ),
            BlocProvider<PaymentCubit>(create: (context) => sl<PaymentCubit>()),
          ],
          child: PaymentScreen(url: state.extra as String),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRoutes.orderRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<OrdersCubit>(
          create: (context) => sl<OrdersCubit>(),
          child: OrderScreen(),
        );
      },
    ),
  ],
);
