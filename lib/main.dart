import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:w2d_customer_mobile/routes/routes.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/injection_container.dart' as di;
import 'package:w2d_customer_mobile/injection_container.dart';
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CommonCubit>(
          create: (context) => sl<CommonCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
        ),
        drawerTheme: DrawerThemeData(backgroundColor: AppColors.white),
        bottomAppBarTheme: BottomAppBarTheme(color: AppColors.white),
        useMaterial3: true,
      ),
      // home: const CategoryListingScreen(),
    );
  }
}
