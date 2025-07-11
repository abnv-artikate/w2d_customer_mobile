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
import 'package:w2d_customer_mobile/features/data/client/telr_payment_client.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/data/repositories/repository_impl.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/get_collections_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/create_order_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/initiate_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/verify_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/search/search_autocomplete_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/checkout/cubit/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/orders/cubit/orders_cubit.dart';

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
      getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
      getCollectionsUseCase: sl<GetCollectionsUseCase>(),
      searchProductAutoCompleteUseCase: sl<SearchProductAutoCompleteUseCase>(),
      localDatasource: sl<LocalDatasource>(),
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
  sl.registerFactory<CartCubit>(
    () => CartCubit(
      cartSyncUseCase: sl<CartSyncUseCase>(),
      getCartItemUseCase: sl<GetCartUseCase>(),
      updateCartUseCase: sl<UpdateCartUseCase>(),
      getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
    ),
  );
  sl.registerFactory<ShippingCubit>(
    () => ShippingCubit(
      getFreightQuoteUseCase: sl<GetFreightQuoteUseCase>(),
      selectFreightServiceUseCase: sl<SelectFreightServiceUseCase>(),
      calculateInsuranceUseCase: sl<CalculateInsuranceUseCase>(),
      confirmInsuranceUseCase: sl<ConfirmInsuranceUseCase>(),
    ),
  );
  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      initiatePaymentUseCase: sl<InitiatePaymentUseCase>(),
      verifyPaymentUseCase: sl<VerifyPaymentUseCase>(),
    ),
  );
  // sl.registerFactory<OrdersCubit>(
  //   () => OrdersCubit(createOrderUseCase: sl<CreateOrderUseCase>()),
  // );

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
  sl.registerLazySingleton<GetCollectionsUseCase>(
    () => GetCollectionsUseCase(sl<Repository>()),
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
  sl.registerLazySingleton<UpdateCartUseCase>(
    () => UpdateCartUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<CalculateInsuranceUseCase>(
    () => CalculateInsuranceUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<ConfirmInsuranceUseCase>(
    () => ConfirmInsuranceUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetFreightQuoteUseCase>(
    () => GetFreightQuoteUseCase(repository: sl<Repository>()),
  );
  sl.registerLazySingleton<SelectFreightServiceUseCase>(
    () => SelectFreightServiceUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetCurrentLocationUseCase>(
    () => GetCurrentLocationUseCase(),
  );
  sl.registerFactory<SearchProductAutoCompleteUseCase>(
    () => SearchProductAutoCompleteUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<InitiatePaymentUseCase>(
    () => InitiatePaymentUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<VerifyPaymentUseCase>(
    () => VerifyPaymentUseCase(sl<Repository>()),
  );
  // sl.registerLazySingleton<CreateOrderUseCase>(
  //   () => CreateOrderUseCase(sl<Repository>()),
  // );

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
    () => RemoteDatasourceImpl(
      w2dClient: sl<W2DClient>(),
      shippingClient: sl<ShippingClient>(),
      telrPaymentClient: sl<TelrPaymentClient>(),
    ),
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

  final telrPaymentDio = Dio(
    BaseOptions(
      baseUrl: Constants.telrPaymentBaseUrl,
      headers: {'Content-Type': 'application/xml'},
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  telrPaymentDio.interceptors.add(
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
  sl.registerLazySingleton<W2DClient>(
    () => W2DClient(w2dDio, sl<LocalDatasource>()),
  );
  sl.registerLazySingleton<ShippingClient>(() => ShippingClient(shippingDio));
  sl.registerLazySingleton<TelrPaymentClient>(
    () => TelrPaymentClient(telrPaymentDio),
  );

  /// Shared Preference
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  /// Network connection
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
