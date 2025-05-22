import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/core/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/cart_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_dropdown_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_list_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int? _selectedShippingIndex;
  String address = "Tap to set delivery location";

  final List<Map<String, String>> shippingMethods = [
    {
      'label': 'Courier (Air)',
      'serviceType': 'Upto Door',
      'shippingFee': '26860',
      'transitEta': '5',
    },
    {
      'label': 'Air Freight',
      'serviceType': 'Upto Door',
      'shippingFee': '26860',
      'transitEta': '5',
    },
    {
      'label': 'Air Freight',
      'serviceType': 'Upto Port',
      'shippingFee': '26860',
      'transitEta': '5',
    },
    {
      'label': 'Sea Freight',
      'serviceType': 'Upto Door',
      'shippingFee': '26860',
      'transitEta': '5',
    },
    {
      'label': 'Sea Freight',
      'serviceType': 'Upto Port',
      'shippingFee': '26860',
      'transitEta': '5',
    },
  ];

  @override
  void initState() {
    callGetCartItemApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CartItemEntity> cartItems = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        actions: [LocationWidget(onTap: () {}, address: address)],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemLoaded) {
            cartItems = state.cartItems;
            // callGetFreightQuoteApi(cartItems);
            callLocationApi();
          } else if (state is CartError) {
            widget.showErrorToast(context: context, message: state.error);
          }

          if (state is GetLocationLoaded) {
            address = "${state.location.city}, ${state.location.country}";
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
                          onCheckBoxTap: () {},
                          onIncrementTap: () {},
                          onDecrementTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: cartItems.length,
                    ),
                    _showBreakdown(cartItems),
                    Row(
                      children: [
                        CustomFilledButtonWidget(
                          title: 'Proceed To Buy',
                          color: AppColors.worldGreen,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          horizontalMargin: 20,
                          onTap: () {},
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

  // Widget _proceedToBuyButton() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       color: AppColors.worldGreen,
  //     ),
  //     child: Text(
  //       'Proceed to buy',
  //       style: TextStyle(
  //         color: AppColors.white,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 28,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  _showBreakdown(List<CartItemEntity> cartItems) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.worldGreen),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Estimated Total:'),
          Text("${_calculateEstimatedTotal(cartItems)}"),
          Row(
            children: [
              Text('Select shipping options:'),
              Spacer(),
              ShippingMethodDropdownWidget(
                shippingMethodText: "shippingMethod",
                onTap: () {
                  _shippingMethodBottomSheet();
                },
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text('Goods Value'),
              Spacer(),
              Text("${_calculateGoodsValue(cartItems)}"),
            ],
          ),
          Row(
            children: [
              Text('Platform Fee'),
              Spacer(),
              Text("${_calculatePlatformFees(cartItems)}"),
            ],
          ),
          Row(
            children: [
              Text('Local Transit Fee'),
              Spacer(),
              Text("${_calculateLocalTransitFees(cartItems)}"),
            ],
          ),
          Row(
            children: [
              Text('Export Freight / Packing / Other Fees'),
              Spacer(),
              Text('${_calculateExportFreightPackingOtherFees()}'),
            ],
          ),
          Row(
            children: [
              Text('Dest Duty / Taxes / Other Fees'),
              Spacer(),
              Text('${_calculateDestDutyTaxesOtherFees()}'),
            ],
          ),
          Row(
            children: [
              Text('Transit Insurance'),
              Spacer(),
              Text('${_calculateTransitInsurance()}'),
            ],
          ),
        ],
      ),
    );
  }

  _shippingMethodBottomSheet() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 1,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 28),
              child: ListView(
                children: [
                  Text(
                    'Select Shipping Method',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  ...List.generate(
                    shippingMethods.length,
                    (index) => ShippingMethodListItemWidget(
                      label: shippingMethods[index]['label']!,
                      serviceType: shippingMethods[index]['serviceType']!,
                      shippingFee: shippingMethods[index]['shippingFee']!,
                      transitEta: shippingMethods[index]['transitEta']!,
                      isSelected: _selectedShippingIndex == index,
                      onTap: () {
                        setModalState(() {
                          if (_selectedShippingIndex == index) {
                            _selectedShippingIndex = null;
                          } else {
                            _selectedShippingIndex = index;
                          }
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      BlankButtonWidget(
                        title: 'Cancel',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        onTap: () {
                          context.pop();
                        },
                      ),
                      Spacer(),
                      CustomFilledButtonWidget(
                        title: 'Select',
                        color: AppColors.worldGreen,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double _calculateEstimatedTotal(List<CartItemEntity> cartItems) {
    return _calculateGoodsValue(cartItems) +
        _calculatePlatformFees(cartItems) +
        _calculateLocalTransitFees(cartItems) +
        _calculateExportFreightPackingOtherFees() +
        _calculateDestDutyTaxesOtherFees() +
        _calculateTransitInsurance();
  }

  double _calculateGoodsValue(List<CartItemEntity> cartItems) {
    double totalGoodsValue = 0.0;

    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalGoodsValue += double.parse(item.product.salePrice);
      }
    }

    return totalGoodsValue;
  }

  double _calculatePlatformFees(List<CartItemEntity> cartItems) {
    return 0.0;
  }

  double _calculateLocalTransitFees(List<CartItemEntity> cartItems) {
    double totalTransitFee = 0.0;

    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalTransitFee += double.parse(item.product.localTransitFee);
      }
    }

    return totalTransitFee;
  }

  double _calculateExportFreightPackingOtherFees() {
    return 0.0;
  }

  double _calculateDestDutyTaxesOtherFees() {
    return 0.0;
  }

  double _calculateTransitInsurance() {
    return 0.0;
  }

  void callGetFreightQuoteApi({
    required List<CartItemEntity> cartItems,
    required LocationEntity address,
  }) {
    context.read<ShippingCubit>().getFreightQuote(
      GetFreightQuoteParams(
        destinationCountry: address.country,
        destinationCity: address.city,
        destinationLatitude: address.latitude,
        destinationLongitude: address.longitude,
        itemsGoods: _calculateGoodsValue(cartItems).toString(),
        items:
            cartItems.map((e) {
              if (e.isChecked) {
                return Items(
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
                          ? e.product.packagingDetails
                              .map(
                                (e) => Dimensions(
                                  kiloGrams: double.parse(e.weight.value),
                                  length: double.parse(e.length.value),
                                  width: double.parse(e.width.value),
                                  height: double.parse(e.height.value),
                                  addWoodenPacking: true,
                                ),
                              )
                              .toList()
                          : e.product.packagingDetails
                              .map(
                                (e) => Dimensions(
                                  kiloGrams: double.parse(e.weight.value),
                                  length: double.parse(e.length.value),
                                  width: double.parse(e.width.value),
                                  height: double.parse(e.height.value),
                                  addWoodenPacking: false,
                                ),
                              )
                              .toList(),
                );
              }
            }).toList(),
      ),
    );
  }

  void callGetCartItemApi() {
    context.read<CartCubit>().getCartItems();
  }

  void callLocationApi() {
    context.read<CartCubit>().getCurrentLocation();
  }
}
