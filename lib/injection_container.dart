import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w2d_customer_mobile/core/config/my_shared_pref.dart';
import 'package:w2d_customer_mobile/core/network/network_info.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/client/shipping_client.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/data/repositories/repository_impl.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      sendOtpUseCase: sl<SendOtpUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
    ),
  );

  sl.registerFactory<CommonCubit>(
    () => CommonCubit(
      categoriesHierarchyUseCase: sl<CategoriesHierarchyUseCase>(),
    ),
  );

  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(
      productCategoryUseCase: sl<ProductCategoryUseCase>(),
      productViewUseCase: sl<ProductViewUseCase>(),
      cartSyncUseCase: sl<CartSyncUseCase>(),
      getCartUseCase: sl<GetCartUseCase>(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<CategoriesHierarchyUseCase>(
    () => CategoriesHierarchyUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<ProductCategoryUseCase>(
    () => ProductCategoryUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<ProductViewUseCase>(
    () => ProductViewUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<CartSyncUseCase>(
    () => CartSyncUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(sl<Repository>()),
  );

  /// Repositories
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      localDatasource: sl<LocalDatasource>(),
      remoteDatasource: sl<RemoteDatasource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  /// Datasource
  sl.registerLazySingleton<LocalDatasource>(
    () => LocalDataSourceImpl(sl<MySharedPref>()),
  );
  sl.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(client: sl<RestClient>()),
  );

  /// Core
  sl.registerLazySingleton<MySharedPref>(
    () => MySharedPref(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnection>()),
  );

  /// Initializing Dio
  final w2dDio = Dio(
    BaseOptions(
      baseUrl: Constants.w2dBaseUrl,
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  w2dDio.interceptors.add(
    LogInterceptor(
      request: true,
      error: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      logPrint: (value) => log(value.toString()),
    ),
  );

  final shippingDio = Dio(
    BaseOptions(
      baseUrl: Constants.shippingBaseUrl,
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  shippingDio.interceptors.add(
    LogInterceptor(
      request: true,
      error: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      logPrint: (value) => log(value.toString()),
    ),
  );

  /// Clients
  sl.registerLazySingleton<RestClient>(() => RestClient(w2dDio));
  sl.registerLazySingleton<ShippingClient>(() => ShippingClient(shippingDio));

  /// Shared Preference
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  /// Network connection
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
