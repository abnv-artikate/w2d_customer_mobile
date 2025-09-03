import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/order_success_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/pending_order_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/payment/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/orders/orders_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/fees_breakdown_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class CheckoutScreen extends StatefulWidget {
  final CheckOutScreenEntity checkOutScreenEntity;

  const CheckoutScreen({super.key, required this.checkOutScreenEntity});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool? isTransitInsured;

  // int? selectedAdd;
  CustomerAddressesEntity? selectedAdd;

  List<CustomerAddressesEntity> addressList = [];

  @override
  initState() {
    _callGetSavedAddressApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Screen")),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is InitiatePaymentLoaded) {
                _callPendingOrderApi(response: state.response);
              } else if (state is InitiatePaymentError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is VerifyPaymentLoaded) {
                if (state.response.status == 'A') {
                  _callOrderSuccessApi(
                    OrderSuccessParams(
                      paymentReference: state.paymentRef,
                      gatewayTxnId: state.response.tranRef,
                      cartId: widget.checkOutScreenEntity.cartSessionKey,
                    ),
                  );
                } else {
                  widget.showErrorToast(
                    context: context,
                    message: state.response.message,
                  );
                }
              } else if (state is VerifyPaymentError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is OrderPendingLoaded) {
                context
                    .push(AppRoutes.paymentRoute, extra: state.startUrl)
                    .then((_) {
                      _callConfirmPaymentApi(state.transactionCode);
                    });
                widget.showErrorToast(
                  context: context,
                  message: "Order Pending Created",
                );
              } else if (state is OrderPendingError) {
                widget.showErrorToast(
                  context: context,
                  message: "Error while creating order",
                );
              }

              if (state is OrderSuccessLoaded) {
                _callResetShipping();
                context.pop();
              } else if (state is OrderSuccessError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {
                    if (state is GetSavedAddressLoaded) {
                      addressList = state.list;
                      selectedAdd = state.defaultAdd;
                    } else if (state is GetSavedAddressError) {
                      widget.showErrorToast(
                        context: context,
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return _savedAddress();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: BlankButtonWidget(
                    title: "Add Address",
                    width: (MediaQuery.of(context).size.width * 0.5),
                    height: 50,
                    borderRadius: 4,
                    onTap: () {},
                  ),
                ),
                FeesBreakdownWidget(),
                SizedBox(height: 5),
                BlocBuilder<CartShippingCubit, CartShippingState>(
                  builder: (context, state) {
                    return CustomFilledButtonWidget(
                      title: "Proceed",
                      color: AppColors.worldGreen,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {
                        if (selectedAdd != null) {
                          _callInitiatePaymentApi(
                            cartId: widget.checkOutScreenEntity.cartSessionKey,
                            amount:
                                state.feeBreakdown!.estimatedTotal.toString(),
                            firstName: selectedAdd?.fullName ?? "",
                            street: selectedAdd?.addressLine1 ?? "",
                            city: selectedAdd?.city ?? "",
                            country: selectedAdd?.country ?? "",
                            phone: selectedAdd?.primaryPhoneNumber ?? "",
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Select Address!!"),
                              backgroundColor: AppColors.softWhite71,
                            ),
                          );
                        }
                        // _clearTextFields();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _savedAddress() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedAdd = addressList[index];
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border:
                  selectedAdd?.id == addressList[index].id
                      ? Border.all(color: AppColors.worldGreen)
                      : null,
              boxShadow: [
                BoxShadow(
                  color:
                      selectedAdd?.id == addressList[index].id
                          ? AppColors.worldGreen
                          : AppColors.deepBlue,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Address Id: ${addressList[index].id.toString()}'),
                Text('Name: ${addressList[index].fullName}'),
                Text('Phone No: ${addressList[index].primaryPhoneNumber}'),
                Text('Address Type: ${addressList[index].addressType}'),
                Text(
                  'Address : ${addressList[index].addressLine1}, ${addressList[index].city}, ${addressList[index].country}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _callConfirmInsuranceApi({
  //   required String quoteToken,
  //   required bool addInsurance,
  // }) {
  //   context.read<CartShippingCubit>().confirmInsurance(
  //     ConfirmInsuranceParams(
  //       quoteToken: quoteToken,
  //       addInsurance: addInsurance,
  //     ),
  //   );
  // }

  void _callInitiatePaymentApi({
    required String cartId,
    required String amount,
    required String firstName,
    required String street,
    required String city,
    required String country,
    String zip = "",
    required String phone,
  }) {
    context.read<PaymentCubit>().initiatePayment(
      cartId: cartId,
      amount: amount,
      firstName: firstName,
      street: street,
      city: city,
      country: country,
      phone: phone,
    );
  }

  void _callConfirmPaymentApi(String transCode) {
    context.read<PaymentCubit>().verifyPayment(transCode);
  }

  void _callPendingOrderApi({required PaymentResponseEntity response}) {
    context.read<OrdersCubit>().pendingOrder(
      params: OrderPendingParams(
        cartId: widget.checkOutScreenEntity.cartSessionKey,
        addressId: 87,
        quoteToken:
            widget.checkOutScreenEntity.freightQuoteEntityData!.quoteToken,
        transitInsurance:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .insuranceAmt ??
            0,
        platformFee: 0,
        destinationDuty: 0,
        vat: 0,
        localTransitFee: widget.checkOutScreenEntity.localTransitFee,
        currency: "AED",
        shippingCost:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .freightAmount ??
            0,
        productPrice:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .goodsValue ??
            0,
        sumTotal:
            widget
                .checkOutScreenEntity
                .calculateInsuranceEntity
                ?.data
                .netTotal ??
            0,
        file: "",
        orderRef: response.transactionCode,
      ),
      startUrl: response.startUrl,
      transactionCode: response.transactionCode,
    );
  }

  void _callGetSavedAddressApi() {
    context.read<AddressCubit>().getSavedAddress();
  }

  void _callOrderSuccessApi(OrderSuccessParams params) {
    context.read<OrdersCubit>().orderSuccess(params);
  }

  void _callResetShipping() {
    context.read<CartShippingCubit>().resetShipping();
  }
}

class CheckOutScreenEntity {
  final List<CartItemEntity> cartItems;
  FreightQuoteEntityData? freightQuoteEntityData;
  CalculateInsuranceEntity? calculateInsuranceEntity;
  double localTransitFee;
  final bool isTransitInsured;
  final String cartSessionKey;

  CheckOutScreenEntity({
    required this.cartItems,
    this.freightQuoteEntityData,
    this.calculateInsuranceEntity,
    required this.localTransitFee,
    required this.isTransitInsured,
    required this.cartSessionKey,
  });
}
