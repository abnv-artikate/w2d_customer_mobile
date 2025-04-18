import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/routes/routes.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/injection_container.dart' as di;
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'ClassicoURW',
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(color: AppColors.white),
        drawerTheme: DrawerThemeData(backgroundColor: AppColors.white),
        bottomAppBarTheme: BottomAppBarTheme(color: AppColors.white),
        useMaterial3: true,
      ),
      // home: const CategoryListingScreen(),
    );
  }
}
