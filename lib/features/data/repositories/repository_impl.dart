import 'package:dartz/dartz.dart';
import 'package:uuid/v4.dart';
import 'package:w2d_customer_mobile/core/error/exceptions.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/network/network_info.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/data/repositories/repository_conv.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';

class RepositoryImpl extends Repository {
  final LocalDatasource localDatasource;
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> sendOtp({
    required SendOtpParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.sendOtp(
          queries: {"type": params.type},
          body: {"email": params.email},
        );

        return Right(result.message ?? 'OTP sent successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.verifyOtp({
          "email": params.email,
          "otp": params.otp,
        });

        localDatasource.setAccessToken(result.data?.access ?? "");
        localDatasource.setRefreshToken(result.data?.refresh ?? "");
        localDatasource.setUserEmail(
          RepositoryConv.convertVerifyOtpModelToUserEntity(result).email,
        );

        return Right(RepositoryConv.convertVerifyOtpModelToUserEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductCategoryEntity>>>
  getCategoriesHierarchy() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getCategoriesHierarchyModel();

        return Right(
          RepositoryConv.convertCategoriesHierarchyModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ProductCategoryListingEntity>>
  getProductCategoryListing({required ProductCategoryParams params}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getProductCategoriesList({
          "category_slug": params.categorySlug,
        });

        return Right(
          RepositoryConv.convertProductCategoryModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ProductViewEntity>> getProductView({
    required ProductViewParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getProductView(params.productId);

        return Right(RepositoryConv.convertProductViewModelToEntity(result));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> cartSync({
    required CartSyncParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        String cartId = "";
        if (localDatasource.getCartId() != null) {
          cartId = localDatasource.getCartId()!;
        } else {
          localDatasource.setCartId(_generateCartId());
          cartId = localDatasource.getCartId()!;
        }

        final result = await remoteDatasource.cartSync({
          "cart_id": cartId,
          "items": [
            {
              "product_id": params.productId,
              "quantity": params.quantity,
              "variant_id": params.variantId,
            },
          ],
        });

        return Right(result.message ?? 'Add to Cart Success');
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  String _generateCartId() {
    UuidV4 newCartId = UuidV4();

    return newCartId.toString();
  }

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      String cartId = "";
      if (localDatasource.getCartId() != null) {
        cartId = localDatasource.getCartId()!;
      }
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getCart({"cart_id": cartId});

        return Right(RepositoryConv.convertCartModelToEntity(result));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CalculateInsuranceEntity>> calculateInsurance({
    required CalculateInsuranceParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.calculateInsurance({
          "quote_token": params.quoteToken,
        });

        return Right(
          RepositoryConv.convertCalculateInsuranceModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ConfirmInsuranceEntity>> confirmInsurance({
    required ConfirmInsuranceParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.confirmInsurance({
          "quote_token": params.quoteToken,
          "add_insurance": params.addInsurance,
        });

        return Right(
          RepositoryConv.convertConfirmInsuranceModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FreightQuoteEntity>> getFreightQuote({
    required GetFreightQuoteParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getFreightQuote({
          "user_details": {"user_email": "christine.rozario@world2doorcom"},
          "quote_by": "MARKETPLACE",
          "quote_by_email": "christine.rozario@world2door.com",
          "origin_country": "United Arab Emirates",
          "origin_country_short_name": "AE",
          "origin_city": "Dubai",
          "origin_latitude": 25.2048493,
          "origin_longitude": 55.2707828,
          "destination_country": params.destinationCountry,
          "destination_country_short_name": params.destinationCountryShortName,
          "destination_city": params.destinationCity,
          "destination_latitude": params.destinationLatitude,
          "destination_longitude": params.destinationLongitude,
          "items_goods": params.itemsGoods,
          "items": params.items,
        });

        return Right(
          RepositoryConv.convertGetFreightQuoteModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SelectFreightServiceEntity>> selectFreightService({
    required SelectFreightServiceParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.selectFreightService({
          "quote_token": params.quoteToken,
          "selected_courier_type": params.selectedCourierType,
        });

        return Right(
          RepositoryConv.convertSelectFreightServiceModelToEntity(result),
        );
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
