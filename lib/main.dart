import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/routes/routes.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/injection_container.dart' as di;
import 'package:w2d_customer_mobile/injection_container.dart';
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) =>
          BlocProvider<CommonCubit>(
            create: (context) => sl<CommonCubit>(),
            child: MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.white,
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
        ),
        appBarTheme: AppBarTheme(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
        ),
        drawerTheme: DrawerThemeData(backgroundColor: AppColors.white),
        bottomAppBarTheme: BottomAppBarTheme(color: AppColors.white),
        navigationBarTheme: NavigationBarThemeData(
          surfaceTintColor: AppColors.transparent,
        ),
        fontFamily: 'DMSans',
        useMaterial3: true,
      ),
    );
  }
}
