import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';

abstract class Repository {
  /// Auth Repositories
  Future<Either<Failure, String>> sendOtp({required SendOtpParams params});

  Future<Either<Failure, UserEntity>> verifyOtp({
    required VerifyOtpParams params,
  });

  /// Category Repositories
  Future<Either<Failure, ProductCategoryListingEntity>>
  getProductCategoryListing({required ProductCategoryParams params});

  Future<Either<Failure, List<ProductCategoryEntity>>> getCategoriesHierarchy();

  /// Product Repositories
  Future<Either<Failure, ProductViewEntity>> getProductView({
    required ProductViewParams params,
  });

  /// Cart Sync Repository
  Future<Either<Failure, String>> cartSync({required CartSyncParams params});

  /// Cart Repositories
  Future<Either<Failure, CartEntity>> getCart({
    required GetCartParams params,
  });
}
