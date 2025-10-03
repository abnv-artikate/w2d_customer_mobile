import 'package:dartz/dartz.dart';
import 'package:uuid/v4.dart';
import 'package:w2d_customer_mobile/core/error/exceptions.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/network/network_info.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/data/repositories/repository_conv.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/browsing_history/browsing_history_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/updated_cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/order_pending_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/recommendations/recommendations_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/related_products/related_products_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/confirm_payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/wishlist/wishlist_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/browsing_history/add_browsing_history_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_list_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/order_success_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/pending_order_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/update_order_by_id_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/add_wishlist_usecase.dart';

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
        localDatasource.setUserName(
          RepositoryConv.convertVerifyOtpModelToUserEntity(result).fullName,
        );
        localDatasource.setStoreID(
          RepositoryConv.convertVerifyOtpModelToUserEntity(result).store,
        );
        localDatasource.setStoreAuthKey(
          RepositoryConv.convertVerifyOtpModelToUserEntity(result).authKey,
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
  Future<Either<Failure, List<SubCategoriesEntity>>>
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
  Future<Either<Failure, CollectionsEntity>> getCollections() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getCollections();

        return Right(RepositoryConv.convertCollectionsModelToEntity(result));
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
          localDatasource.setCartId(_generateUniqueCartId());
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

  String _generateUniqueCartId() {
    UuidV4 uuid = UuidV4();

    String newId = uuid.generate();

    return newId;
  }

  @override
  Future<Either<Failure, CartEntity?>> getCart() async {
    try {
      String cartId = "";
      if (localDatasource.getCartId() != null) {
        cartId = localDatasource.getCartId()!.toString();
      } else {
        localDatasource.setCartId(_generateUniqueCartId());
        cartId = localDatasource.getCartId()!.toString();
      }
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getCart({"cart_id": cartId});

        return result.hasData
            ? Right(result.toEntity())
            : Left(ServerFailure(message: "No Data Present in Cart"));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UpdatedCartEntity>> updateCart({
    required UpdateCartParams params,
  }) async {
    // {"cart_id":1286,"product_id":"909f1459-1a4a-455b-9eb9-f8c1ae55c8e7","quantity":2,"checked":false}
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.updateCart({
          "cart_id": params.cartId,
          "product_id": params.productId,
          "quantity": params.quantity,
          "checked": params.checked,
        });

        return Right(RepositoryConv.convertUpdateCartModelToEntity(result));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SearchResultAutoCompleteEntity>>
  searchProductAutoComplete({required String params}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.searchProductAutoComplete({
          "q": params,
        });

        return Right(RepositoryConv.convertSearchResultModelToEntity(result));
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
    required Map<String, dynamic> params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getFreightQuote(params);

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
          "selected_courier_type": _getCourierType(params.serviceIndex),
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

  String _getCourierType(int? shippingIndex) {
    switch (shippingIndex) {
      case 0:
        return "DOORCOURIER";
      case 1:
        return "DOORAIR";
      case 2:
        return "PORTAIR";
      case 3:
        return "DOORSEA";
      case 4:
        return "PORTSEA";
      case 5:
        return "DOORLAND";
      default:
        return "";
    }
  }

  @override
  Future<Either<Failure, PaymentResponseEntity>> initiatePayment(
    PaymentRequestEntity request,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.initiatePayment(request);

        return Right(RepositoryConv.convertTelrPaymentResponseToEntity(result));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ConfirmPaymentResponseEntity>> verifyPayment(
    String transCode,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.verifyPayment(transCode);

        return Right(ConfirmPaymentResponseEntity.fromModel(result));
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OrderPendingEntity>> orderPending(
    OrderPendingParams params,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.orderPending(params.toJson());

        return Right(result.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createAddress(
    CreateAddressParams params,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.saveCustomerAddress(
          params.toJson(),
        );

        return Right("Success");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CustomerAddressesEntity>>>
  getCustomerAddresses() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getCustomerAddresses();

        return Right(result.data?.map((e) => e.toEntity()).toList() ?? []);
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> orderSuccess(
    OrderSuccessParams params,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.orderSuccess(params.toJson());

        return Right("result is here do something.");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder(String params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.cancelOrder(params);

        return Right("result is here do something.");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getOrderByID(String params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getOrderByID(params);

        return Right("result is here do something.");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OrderListEntity>> getOrdersList(
    GetOrdersListParams params,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getOrdersList(params.toJson());

        return Right(result.results!.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateOrder(UpdateOrderParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.updateOrder(
          id: params.id,
          body: params.toJson(),
        );

        return Right("result is here do something.");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addWishlist(AddWishListParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.addWishlist(params.toJson());

        return Right(result.message ?? "Add to Wishlist Success");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteWishList(String params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.deleteWishlist(params);

        return Right(result.message ?? "Wishlist item delete success");
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, WishListEntity>> getWishlist() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getWishlist();

        return Right(result.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RecommendationsEntity>> getRecommendations(
    String productId,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getRecommendations(productId);

        return Right(result.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RelatedProductsEntity>> getRelatedProducts(
    String productId,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.getRelatedProducts(productId);

        return Right(result.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addBrowsingHistory(
    AddBrowsingHistoryParams params,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        String uniqueId = "";
        if (localDatasource.getUniqueId() != null) {
          uniqueId = localDatasource.getUniqueId()!;
        } else {
          localDatasource.setUniqueId(_generateUniqueCartId());
          uniqueId = localDatasource.getUniqueId()!.toString();
        }

        final result = await remoteDatasource.addBrowsingHistory({
          "product_id": params.productId,
          "unique_key": uniqueId,
        });

        return Right(result.message ?? 'Add to browsing history');
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BrowsingHistoryEntity>> getBrowsingHistory() async {
    try {
      if (await networkInfo.isConnected) {
        String uniqueId = "";
        if (localDatasource.getUniqueId() != null) {
          uniqueId = localDatasource.getUniqueId()!.toString();
        } else {
          localDatasource.setUniqueId(_generateUniqueCartId());
          uniqueId = localDatasource.getUniqueId()!.toString();
        }

        final result = await remoteDatasource.getBrowsingHistory({
          "unique_key": uniqueId,
        });

        return Right(result.toEntity());
      } else {
        return Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
