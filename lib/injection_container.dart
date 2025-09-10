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
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/get_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/categories_hierarchy_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/get_collections_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_manual_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/cancel_order_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_by_id_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_list_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/order_success_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/pending_order_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/update_order_by_id_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/initiate_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/verify_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/search/search_autocomplete_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/add_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/delete_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/get_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/payment/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/orders/orders_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit
  sl.registerFactory<CommonCubit>(
    () => CommonCubit(
      categoriesHierarchyUseCase: sl<CategoriesHierarchyUseCase>(),
      getCollectionsUseCase: sl<GetCollectionsUseCase>(),
      searchProductAutoCompleteUseCase: sl<SearchProductAutoCompleteUseCase>(),
      localDatasource: sl<LocalDatasource>(),
      sendOtpUseCase: sl<SendOtpUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
    ),
  );

  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(
      productCategoryUseCase: sl<ProductCategoryUseCase>(),
      productViewUseCase: sl<ProductViewUseCase>(),
      cartSyncUseCase: sl<CartSyncUseCase>(),
      getCartUseCase: sl<GetCartUseCase>(),
      addWishListUseCase: sl<AddWishListUseCase>(),
      getWishListUseCase: sl<GetWishListUseCase>(),
      deleteWishListUseCase: sl<DeleteWishListUseCase>(),
      localDatasource: sl<LocalDatasource>(),
    ),
  );
  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      initiatePaymentUseCase: sl<InitiatePaymentUseCase>(),
      verifyPaymentUseCase: sl<VerifyPaymentUseCase>(),
      localDatasource: sl<LocalDatasource>(),
    ),
  );
  sl.registerFactory<AddressCubit>(
    () => AddressCubit(
      createAddressUseCase: sl<CreateAddressUseCase>(),
      getAddressUseCase: sl<GetAddressUseCase>(),
    ),
  );
  sl.registerFactory<OrdersCubit>(
    () => OrdersCubit(
      orderPendingUseCase: sl<OrderPendingUseCase>(),
      orderSuccessUseCase: sl<OrderSuccessUseCase>(),
      getOrdersByIdUseCase: sl<GetOrdersByIdUseCase>(),
      getOrdersListUseCase: sl<GetOrdersListUseCase>(),
    ),
  );
  sl.registerLazySingleton<CartShippingCubit>(
    () => CartShippingCubit(
      cartSyncUseCase: sl<CartSyncUseCase>(),
      getCartItemUseCase: sl<GetCartUseCase>(),
      getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
      getManualLocationUseCase: sl<GetManualLocationUseCase>(),
      updateCartUseCase: sl<UpdateCartUseCase>(),
      getFreightQuoteUseCase: sl<GetFreightQuoteUseCase>(),
      selectFreightServiceUseCase: sl<SelectFreightServiceUseCase>(),
      calculateInsuranceUseCase: sl<CalculateInsuranceUseCase>(),
      confirmInsuranceUseCase: sl<ConfirmInsuranceUseCase>(),
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
  sl.registerLazySingleton<GetManualLocationUseCase>(
    () => GetManualLocationUseCase(),
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
  sl.registerLazySingleton<OrderPendingUseCase>(
    () => OrderPendingUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<OrderSuccessUseCase>(
    () => OrderSuccessUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<CreateAddressUseCase>(
    () => CreateAddressUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetAddressUseCase>(
    () => GetAddressUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetOrdersListUseCase>(
    () => GetOrdersListUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetOrdersByIdUseCase>(
    () => GetOrdersByIdUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<UpdateOrderByIdUseCase>(
    () => UpdateOrderByIdUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<CancelOrderUseCase>(
    () => CancelOrderUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<AddWishListUseCase>(
    () => AddWishListUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<GetWishListUseCase>(
    () => GetWishListUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<DeleteWishListUseCase>(
    () => DeleteWishListUseCase(sl<Repository>()),
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
      logPrint: (value) => log(value.toString(), name: 'w2dClient'),
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
      logPrint: (value) => log(value.toString(), name: 'shippingClient'),
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
      logPrint: (value) => log(value.toString(), name: 'telrPaymentClient'),
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
