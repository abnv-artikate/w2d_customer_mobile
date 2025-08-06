import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/updated_cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/confirm_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/select_freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/confirm_payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/address/create_address_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
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

abstract class Repository {
  /// Auth Repositories
  Future<Either<Failure, String>> sendOtp({required SendOtpParams params});

  Future<Either<Failure, UserEntity>> verifyOtp({
    required VerifyOtpParams params,
  });

  /// Category Repositories
  Future<Either<Failure, ProductCategoryListingEntity>>
  getProductCategoryListing({required ProductCategoryParams params});

  Future<Either<Failure, List<SubCategoriesEntity>>> getCategoriesHierarchy();

  Future<Either<Failure, CollectionsEntity>> getCollections();

  /// Product Repositories
  Future<Either<Failure, ProductViewEntity>> getProductView({
    required ProductViewParams params,
  });

  /// Cart Sync Repository
  Future<Either<Failure, String>> cartSync({required CartSyncParams params});

  /// Cart Repositories
  Future<Either<Failure, CartEntity?>> getCart();

  Future<Either<Failure, UpdatedCartEntity>> updateCart({
    required UpdateCartParams params,
  });

  /// Shipping Repository
  Future<Either<Failure, FreightQuoteEntity>> getFreightQuote({
    required Map<String, dynamic> params,
  });

  Future<Either<Failure, SelectFreightServiceEntity>> selectFreightService({
    required SelectFreightServiceParams params,
  });

  Future<Either<Failure, CalculateInsuranceEntity>> calculateInsurance({
    required CalculateInsuranceParams params,
  });

  Future<Either<Failure, ConfirmInsuranceEntity>> confirmInsurance({
    required ConfirmInsuranceParams params,
  });

  /// Payment Repository

  // Future<Either<Failure, PaymentResponse>> createPayment(
  //   CreatePaymentParams params,
  // );
  //
  // Future<Either<Failure, PaymentResponse>> verifyPayment(
  //   VerifyPaymentParams params,
  // );

  Future<Either<Failure, SearchResultAutoCompleteEntity>>
  searchProductAutoComplete({required String params});

  Future<Either<Failure, PaymentResponseEntity>> initiatePayment(
    PaymentRequestEntity request,
  );

  Future<Either<Failure, ConfirmPaymentResponseEntity>> verifyPayment(
    String transCode,
  );

  /// Address Repository
  Future<Either<Failure, String>> createAddress(CreateAddressParams params);

  Future<Either<Failure, List<CustomerAddressesEntity>>> getCustomerAddresses();

  /// Order Repository
  Future<Either<Failure, String>> orderPending(OrderPendingParams params);

  Future<Either<Failure, String>> orderSuccess(OrderSuccessParams params);

  /// Orders Repository
  Future<Either<Failure, String>> cancelOrder(String params);

  Future<Either<Failure, String>> updateOrder(UpdateOrderParams params);

  Future<Either<Failure, String>> getOrderByID(String params);

  Future<Either<Failure, OrderListEntity>> getOrdersList(GetOrdersListParams params);
}
