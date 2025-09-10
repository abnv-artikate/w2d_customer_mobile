import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_manual_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/cart_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/fees_breakdown_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_list_item_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _addCtrl = TextEditingController();
  final FocusNode _addNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    final cubit = context.read<CartShippingCubit>();
    cubit.resetShipping();
    cubit.getCartItems();
  }

  @override
  void dispose() {
    _addCtrl.dispose();
    _addNode.dispose();
    super.dispose();
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
          BlocBuilder<CartShippingCubit, CartShippingState>(
            builder: (context, state) {
              return LocationWidget(
                onTap: () => _setLocationWidget(),
                address:
                    state.hasLocationData
                        ? '${state.location?.city}, ${state.location?.country}'
                        : state.isLocationLoading
                        ? "Loading Location"
                        : "Set Location",
              );
            },
          ),
        ],
      ),
      body: BlocListener<CartShippingCubit, CartShippingState>(
        listener: (context, state) {
          if (state.hasSuccess) {
            widget.showErrorToast(
              context: context,
              message: state.successMessage ?? "Success Message",
            );
          }

          if (state.hasError) {
            widget.showErrorToast(
              context: context,
              message: state.errorMessage ?? "Error Message",
            );
          }

          if (state.hasLocationData &&
              state.hasCartData &&
              !state.hasFreightQuoteData) {
            _callGetFreightQuoteApi(
              cartItems: state.cart!.items,
              location: state.location!,
            );
          }

          if (state.hasFreightQuoteData &&
              state.freightQuote?.quoteToken != null &&
              !state.hasInsuranceData &&
              state.selectedShippingIndex != null) {
            _callCalculateInsuranceApi(state.freightQuote!.quoteToken);
          }
        },
        child: BlocBuilder<CartShippingCubit, CartShippingState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildCartItemsSection(state),
                        SizedBox(height: 10),
                        _buildShippingBreakdownSection(state),
                      ],
                    ),
                  ),
                ),
                _buildBottomSection(state),
                SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItemsSection(CartShippingState state) {
    if (state.isCartLoading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.worldGreen),
          ),
        ),
      );
    }

    if (!state.hasCartData || state.cart!.items.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            final cartItem = state.cart!.items[index];
            return CartItemWidget(
              cartItem: cartItem,
              onCheckBoxTap:
                  () => _updateCartItem(
                    cartItem: cartItem,
                    checked: !cartItem.isChecked,
                  ),
              onIncrementTap:
                  () => _updateCartItem(
                    cartItem: cartItem,
                    quantity: cartItem.quantity + 1,
                  ),
              onDecrementTap:
                  () => _updateCartItem(
                    cartItem: cartItem,
                    quantity: cartItem.quantity - 1,
                  ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: state.cart!.items.length,
        ),
      ],
    );
  }

  Widget _buildShippingBreakdownSection(CartShippingState state) {
    if (!state.hasCartData || state.cart!.items.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FeesBreakdownWidget(
        onShippingMethodDropdownTap: () => _handleShippingMethodDropdown(state),
      ),
    );
  }

  Widget _buildBottomSection(CartShippingState state) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.softWhite80,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CustomFilledButtonWidget(
        title: Text(
          _getButtonTitle(state),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        color:
            !state.hasCartData || state.cart!.items.isEmpty
                ? AppColors.softWhite80
                : AppColors.worldGreen80,
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        horizontalMargin: 0,
        borderRadius: 4,
        onTap: () {
          state.isAnyLoading ? null : _handleProceedToBuy(state);
        },
      ),
    );
  }

  String _getButtonTitle(CartShippingState state) {
    if (state.isAnyLoading) {
      return 'Loading...';
    }

    if (!state.hasCartData || state.cart!.items.isEmpty) {
      return 'Add Items to Cart';
    }

    final checkedItems =
        state.cart!.items.where((item) => item.isChecked).toList();
    if (checkedItems.isEmpty) {
      return 'Select Items to Continue';
    }

    if (!state.hasLocationData) {
      return 'Set Delivery Location';
    }

    if (!state.hasFreightQuoteData) {
      return 'Get Shipping Quote';
    }

    if (state.selectedShippingIndex == null) {
      return 'Select Shipping Method';
    }

    return 'Proceed To Buy';
  }

  void _updateCartItem({
    required CartItemEntity cartItem,
    int? quantity,
    bool? checked,
  }) {
    context.read<CartShippingCubit>().updateCart(
      UpdateCartParams(
        cartId: cartItem.cart,
        productId: cartItem.product.id,
        quantity: quantity ?? cartItem.quantity,
        checked: checked ?? cartItem.isChecked,
      ),
    );
  }

  _handleShippingMethodDropdown(CartShippingState state) {
    final checkedItems =
        state.cart!.items.where((item) => item.isChecked).toList();
    if (checkedItems.isEmpty) {
      widget.showErrorToast(
        context: context,
        message: "Please select items from cart",
      );
    }

    _shippingMethodBottomSheet(state);
  }

  void _handleProceedToBuy(CartShippingState state) {
    if (!state.hasCartData || state.cart!.items.isEmpty) {
      widget.showErrorToast(
        context: context,
        message: "Please add items to cart",
      );
      return;
    }

    final checkedItems =
        state.cart!.items.where((item) => item.isChecked).toList();
    if (checkedItems.isEmpty) {
      widget.showErrorToast(
        context: context,
        message: "Please select items from cart",
      );
      return;
    }

    if (!state.hasLocationData) {
      _setLocationWidget();
      return;
    }

    if (state.selectedShippingIndex == null) {
      _handleShippingMethodDropdown(state);
      return;
    }

    if (!_callCheckUserLoginApi()) {
      widget.showErrorToast(
        context: context,
        message: "You are not logged in!",
      );
      return;
    }

    _navigateToCheckout(state);
  }

  void _navigateToCheckout(CartShippingState state) {
    context
        .push(
          AppRoutes.checkoutRoute,
          extra: CheckOutScreenEntity(
            cartItems: state.cart!.items,
            freightQuoteEntityData: state.freightQuote,
            calculateInsuranceEntity: state.insuranceData,
            isTransitInsured: state.isTransitInsured,
            localTransitFee: state.feeBreakdown?.localTransitFees ?? 0.0,
            cartSessionKey: state.cart?.sessionKey ?? "",
          ),
        )
        .then((_) {
          _initData();
        });
  }

  void _shippingMethodBottomSheet(CartShippingState state) {
    final freightQuoteEntityData = state.freightQuote;
    if (freightQuoteEntityData == null) return;
    int? localSelectedIndex = state.selectedShippingIndex;

    showModalBottomSheet(
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
                  SizedBox(height: 20),

                  // Courier (Air) - Index 0
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteCourier.doorDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Courier (Air)",
                      serviceType: "Upto Door",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteCourier
                              .doorDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteCourier
                              .doorDelivery
                              .doorDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 0,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 0 ? null : 0;
                        });
                      },
                    ),

                  // Air Freight (Door) - Index 1
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteAir.doorDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Air Freight",
                      serviceType: "Upto Door",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteAir
                              .doorDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteAir
                              .doorDelivery
                              .doorDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 1,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 1 ? null : 1;
                        });
                      },
                    ),

                  // Air Freight (Port) - Index 2
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteAir.portDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Air Freight",
                      serviceType: "Upto Port",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteAir
                              .portDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteAir
                              .portDelivery
                              .portDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 2,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 2 ? null : 2;
                        });
                      },
                    ),

                  // Sea Freight (Door) - Index 3
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteSea.doorDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Sea Freight",
                      serviceType: "Upto Door",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteSea
                              .doorDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteSea
                              .doorDelivery
                              .doorDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 3,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 3 ? null : 3;
                        });
                      },
                    ),
                  // Sea Freight (Port) - Index 4
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteSea.portDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Sea Freight",
                      serviceType: "Upto Port",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteSea
                              .portDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteSea
                              .portDelivery
                              .portDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 4,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 4 ? null : 4;
                        });
                      },
                    ),

                  // Land Freight (Door) - Index 5
                  if (_isShippingOptionAvailable(
                    freightQuoteEntityData.quoteLand.doorDelivery,
                  ))
                    ShippingMethodListItemWidget(
                      label: "Land Freight",
                      serviceType: "Upto Door",
                      shippingFee:
                          freightQuoteEntityData
                              .quoteLand
                              .doorDelivery
                              .totalAmount
                              .toString(),
                      transitEta:
                          freightQuoteEntityData
                              .quoteLand
                              .doorDelivery
                              .doorDeliveryTt
                              .toString(),
                      isSelected: localSelectedIndex == 5,
                      onTap: () {
                        setModalState(() {
                          localSelectedIndex =
                              localSelectedIndex == 5 ? null : 5;
                        });
                      },
                    ),
                  SizedBox(height: 30),

                  // Action buttons
                  Row(
                    children: [
                      BlankButtonWidget(
                        title: 'Cancel',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        onTap: () => context.pop(),
                      ),
                      Spacer(),
                      CustomFilledButtonWidget(
                        title: Text(
                          'Apply',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        color: AppColors.worldGreen,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        onTap: () {
                          if (localSelectedIndex != null) {
                            context.pop();
                            _callSelectFreightServiceApi(
                              quoteToken: freightQuoteEntityData.quoteToken,
                              serviceIndex: localSelectedIndex,
                            );
                          } else {
                            widget.showErrorToast(
                              context: context,
                              message: "Select a shipping method first",
                            );
                          }
                        },
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

  bool _isShippingOptionAvailable(dynamic deliveryOption) {
    return deliveryOption != null && deliveryOption.totalAmount != -1;
  }

  void _setLocationWidget() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Delivery Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GooglePlaceAutoCompleteTextField(
                focusNode: _addNode,
                textEditingController: _addCtrl,
                googleAPIKey: "AIzaSyCBixn2iS2Fm7jDolWu4S5dBqA1avQ7T_g",
                boxDecoration: BoxDecoration(),
                inputDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.softWhite71,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.worldGreen,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.softWhite80,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                ),
                debounceTime: 800,
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (Prediction prediction) async {
                  _callManualLocationApi(
                    GetManualLocationParams(
                      latitude: double.tryParse(prediction.lat ?? "") ?? 0.0,
                      longitude: double.tryParse(prediction.lng ?? "") ?? 0.0,
                    ),
                  );
                  context.pop();
                },
                itemClick: (Prediction prediction) {
                  _addCtrl.text = prediction.description!;
                  _addCtrl.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length),
                  );
                },
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(LucideIcons.mapPin),
                        SizedBox(width: 7),
                        Expanded(child: Text(prediction.description ?? "")),
                      ],
                    ),
                  );
                },
                seperatedBuilder: Divider(),
                isCrossBtnShown: true,
                containerHorizontalPadding: 0,
                placeType: PlaceType.geocode,
              ),
            ],
          ),
        );
      },
    );
  }

  // API call methods
  void _callManualLocationApi(GetManualLocationParams params) async {
    await context.read<CartShippingCubit>().getManualLocation(params);
  }

  void _callGetFreightQuoteApi({
    required List<CartItemEntity> cartItems,
    required LocationEntity location,
  }) async {
    final checkedItems = cartItems.where((item) => item.isChecked).toList();
    final items = checkedItems.map((item) => item.toFreightItem()).toList();

    if (items.isNotEmpty) {
      await context.read<CartShippingCubit>().getFreightQuote(
        params: GetFreightQuoteParams(
          destinationCountry: location.country,
          destinationCountryShortName: location.isoCountryCode,
          destinationCity: location.city,
          destinationLatitude: location.latitude.toString(),
          destinationLongitude: location.longitude.toString(),
          items: items,
        ),
      );
    }
  }

  void _callSelectFreightServiceApi({
    required String quoteToken,
    int? serviceIndex,
  }) {
    context.read<CartShippingCubit>().selectFreightService(
      SelectFreightServiceParams(
        quoteToken: quoteToken,
        serviceIndex: serviceIndex,
      ),
    );
  }

  void _callCalculateInsuranceApi(String quoteToken) {
    context.read<CartShippingCubit>().calculateInsurance(
      CalculateInsuranceParams(quoteToken: quoteToken),
    );
  }

  bool _callCheckUserLoginApi() {
    return context.read<CommonCubit>().isUserLoggedIn();
  }
}
