import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/cart_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_breakdown_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? address;
  LocationEntity? location;

  List<CartItemEntity> cartItems = [];

  @override
  void initState() {
    _callLocationApi();
    _callGetCartItemApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        actions: [
          BlocConsumer<CommonCubit, CommonState>(
            listener: (context, state) {
              if (state is GetLocationLoading) {
                address = "Loading location";
              } else if (state is GetLocationLoaded) {
                location = state.location;
                address = "${state.location.city}, ${state.location.country}";
              } else if (state is GetLocationError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return address != null
                  ? LocationWidget(onTap: () {}, address: address!)
                  : SizedBox();
            },
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemLoaded) {
            cartItems = state.cartItems;
            if (location != null) {
              _callGetFreightQuoteApi(cartItems: cartItems, address: location!);
            }
            //TODO: add manual location  input here.
          } else if (state is UpdateCartLoaded) {
            _callGetCartItemApi();
          } else if (state is CartError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          return state is CartItemLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.worldGreen),
              )
              : cartItems.isEmpty
              ? Center(child: Text('No Items in Cart'))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem: cartItems[index],
                          onCheckBoxTap: () {
                            _callUpdateCartApi(
                              cartId: cartItems[index].cart,
                              productId: cartItems[index].product.id,
                              quantity: cartItems[index].quantity,
                              checked: !cartItems[index].isChecked,
                            );
                          },
                          onIncrementTap: () {
                            _callUpdateCartApi(
                              cartId: cartItems[index].cart,
                              productId: cartItems[index].product.id,
                              quantity: cartItems[index].quantity + 1,
                              checked: cartItems[index].isChecked,
                            );
                          },
                          onDecrementTap: () {
                            _callUpdateCartApi(
                              cartId: cartItems[index].cart,
                              productId: cartItems[index].product.id,
                              quantity: cartItems[index].quantity - 1,
                              checked: cartItems[index].isChecked,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: cartItems.length,
                    ),

                    ShippingBreakdownWidget(
                      cartItems: cartItems,
                      location: location,
                    ),
                    Row(
                      children: [
                        CustomFilledButtonWidget(
                          title: 'Proceed To Buy',
                          color: AppColors.worldGreen,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          horizontalMargin: 20,
                          onTap: () {
                            if (_callCheckUserLoginApi()) {
                              context.push(AppRoutes.checkoutRoute);
                            } else {
                              context.push(AppRoutes.loginRoute);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }

  void _callLocationApi() async {
    await context.read<CommonCubit>().getCurrentLocation();
  }

  void _callGetCartItemApi() {
    context.read<CartCubit>().getCartItems();
  }

  void _callUpdateCartApi({
    required int cartId,
    required String productId,
    required int quantity,
    required bool checked,
  }) {
    context.read<CartCubit>().updateCart(
      UpdateCartParams(
        cartId: cartId,
        productId: productId,
        quantity: quantity,
        checked: checked,
      ),
    );
  }

  void _callGetFreightQuoteApi({
    required List<CartItemEntity> cartItems,
    required LocationEntity address,
  }) {
    List<Items?> items =
        cartItems.map((e) {
          if (e.isChecked) {
            return Items(
              itemsGoods:
                  "${double.parse(e.product.regularPrice) * e.quantity}",
              itemDescription: e.product.productType,
              noOfPkgs: e.product.packagingDetails.length,
              attribute:
                  e.product.isCosmetics
                      ? "cosmetics"
                      : e.product.isPerfume
                      ? "perfumes"
                      : e.product.containsBattery
                      ? "battery"
                      : e.product.containsMagnet
                      ? "magnet"
                      : "",
              hsCode: e.product.hsCode,
              dimensions:
                  e.product.woodenBoxPackaging
                      ? e.product.packagingDetails.map((e) {
                        if (double.parse(e.weight.value) != 0.0 &&
                            double.parse(e.width.value) != 0.0 &&
                            double.parse(e.height.value) != 0.0 &&
                            double.parse(e.length.value) != 0.0) {
                          return Dimensions(
                            kiloGrams: double.parse(e.weight.value),
                            length: double.parse(e.length.value),
                            width: double.parse(e.width.value),
                            height: double.parse(e.height.value),
                            addWoodenPacking: true,
                          );
                        }
                      }).toList()
                      : e.product.packagingDetails.map((e) {
                        if (double.parse(e.weight.value) != 0.0 &&
                            double.parse(e.width.value) != 0.0 &&
                            double.parse(e.height.value) != 0.0 &&
                            double.parse(e.length.value) != 0.0) {
                          return Dimensions(
                            kiloGrams: double.parse(e.weight.value),
                            length: double.parse(e.length.value),
                            width: double.parse(e.width.value),
                            height: double.parse(e.height.value),
                            addWoodenPacking: false,
                          );
                        }
                      }).toList(),
            );
          }
        }).toList();
    if (items.isNotEmpty && items.nonNulls.toList().isNotEmpty) {
      context.read<ShippingCubit>().getFreightQuote(
        GetFreightQuoteParams(
          destinationCountry: address.country,
          destinationCountryShortName: address.isoCountryCode,
          destinationCity: address.city,
          destinationLatitude: address.latitude,
          destinationLongitude: address.longitude,
          items: items,
        ),
      );
    }
  }

  bool _callCheckUserLoginApi() {
    return context.read<CommonCubit>().isUserLoggedIn();
  }
}
