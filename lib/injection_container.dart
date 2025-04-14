import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:w2d_customer_mobile/core/network/network_info.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/client/client.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/data/repositories/repository_impl.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/auth/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      sendOtpUseCase: sl<SendOtpUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(sl<Repository>()),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<Repository>()),
  );

  /// Repositories
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDatasource: sl<RemoteDatasource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  /// Datasource
  sl.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(client: sl<RestClient>()),
  );

  /// Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnection>()),
  );

  /// Initializing Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  dio.interceptors.add(
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
  sl.registerLazySingleton<RestClient>(() => RestClient(dio));

  /// Dependencies
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
