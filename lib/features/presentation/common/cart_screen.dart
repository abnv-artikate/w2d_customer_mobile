import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_manual_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/checkout/checkout_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/checkout/cubit/payment_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/cart_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_breakdown_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_list_item_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? address;
  LocationEntity? location;
  int? selectedShippingIndex;
  FreightQuoteEntityData? freightQuoteEntityData;
  CalculateInsuranceEntity? calculateInsuranceEntity;
  bool isTransitInsured = false;
  String cartSessionKey = "";

  List<CartItemEntity> cartItems = [];

  final TextEditingController _addCtrl = TextEditingController();
  final FocusNode _addNode = FocusNode();

  @override
  void initState() {
    _callLocationApi();
    _callGetCartItemApi();
    super.initState();
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
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is GetLocationLoading) {
                address = "Loading Location";
              } else if (state is GetLocationLoaded) {
                location = state.location;
                address = "${state.location.city}, ${state.location.country}";
                _callGetFreightQuoteApi(
                  cartItems: cartItems,
                  location: location!,
                );
              } else if (state is GetManualLocationLoaded) {
                location = state.location;
                address = "${state.location.city}, ${state.location.country}";
                _callGetFreightQuoteApi(
                  cartItems: cartItems,
                  location: location!,
                );
                context.pop();
              } else if (state is GetLocationError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return LocationWidget(
                onTap: () {
                  _setLocationWidget();
                },
                address: address,
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemLoaded) {
            cartItems = state.cart?.items ?? [];
            cartSessionKey = state.cart?.sessionKey ?? "";
            if (location != null) {
              _callGetFreightQuoteApi(
                cartItems: cartItems,
                location: location!,
              );
            }
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

                    BlocConsumer<ShippingCubit, ShippingState>(
                      listener: (context, state) {
                        if (state is GetFreightQuoteLoaded) {
                          freightQuoteEntityData =
                              state.freightQuoteEntity.data;
                        } else if (state is SelectFreightQuoteLoaded) {
                          _callCalculateInsuranceApi(
                            freightQuoteEntityData!.quoteToken,
                          );
                        } else if (state is CalculateInsuranceLoaded) {
                          calculateInsuranceEntity = state.insuranceEntity;
                        } else if (state is ShippingError) {
                          widget.showErrorToast(
                            context: context,
                            message: state.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              ShippingBreakdownWidget(
                                cartItems: cartItems,
                                location: location,
                                freightQuoteEntityData: freightQuoteEntityData,
                                calculateInsuranceEntity:
                                    calculateInsuranceEntity,
                                selectedShippingIndex: selectedShippingIndex,
                                isTransitInsured: isTransitInsured,
                                onShippingMethodDropdownTap: () {
                                  if (location != null) {
                                    if (freightQuoteEntityData != null) {
                                      _shippingMethodBottomSheet();
                                    } else {
                                      _callGetFreightQuoteApi(
                                        cartItems: cartItems,
                                        location: location!,
                                      );
                                    }
                                  } else {
                                    widget.showErrorToast(
                                      context: context,
                                      message: "Fetching Location Data",
                                    );
                                    _callLocationApi();
                                  }
                                },
                                onTransitInsuranceTap: (bool? value) {
                                  setState(() {
                                    isTransitInsured = value!;
                                  });
                                  _callConfirmInsuranceApi(
                                    quoteToken:
                                        freightQuoteEntityData!.quoteToken,
                                    addInsurance: isTransitInsured,
                                  );
                                },
                              ),
                              CustomFilledButtonWidget(
                                title:
                                    state is GetFreightQuoteLoading ||
                                            state
                                                is CalculateInsuranceLoading ||
                                            state
                                                is SelectFreightQuoteLoading ||
                                            state is ConfirmInsuranceLoading
                                        ? 'Loading...'
                                        : 'Proceed To Buy',
                                color: AppColors.worldGreen,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.9,
                                horizontalMargin: 20,
                                borderRadius: 4,
                                onTap: () {
                                  if (selectedShippingIndex == null) {
                                    if (freightQuoteEntityData != null &&
                                        location != null) {
                                      _shippingMethodBottomSheet();
                                    } else if (location != null) {
                                      _callGetFreightQuoteApi(
                                        cartItems: cartItems,
                                        location: location!,
                                      );
                                    } else {
                                      _setLocationWidget();
                                    }
                                  } else {
                                    if (_callCheckUserLoginApi()) {
                                      context
                                          .push(
                                            AppRoutes.checkoutRoute,
                                            extra: CheckOutScreenEntity(
                                              cartItems: cartItems,
                                              freightQuoteEntityData:
                                                  freightQuoteEntityData,
                                              calculateInsuranceEntity:
                                                  calculateInsuranceEntity,
                                              isTransitInsured:
                                                  isTransitInsured,
                                              localTransitFee:
                                                  _calculateLocalTransitFees(
                                                    cartItems,
                                                  ),
                                              cartSessionKey: cartSessionKey,
                                            ),
                                          )
                                          .then((_) {
                                            _callLocationApi();
                                            _callGetCartItemApi();
                                          });
                                    } else {
                                      // context.push(AppRoutes.loginRoute, extra: true);
                                      // context.push(
                                      //   AppRoutes.checkoutRoute,
                                      //   extra: CheckOutScreenEntity(
                                      //     cartItems: cartItems,
                                      //     freightQuoteEntityData: freightQuoteEntityData,
                                      //     calculateInsuranceEntity:
                                      //         calculateInsuranceEntity,
                                      //     isTransitInsured: isTransitInsured,
                                      //   ),
                                      // );
                                      widget.showErrorToast(
                                        context: context,
                                        message: "you are not logged in !!!",
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
        },
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
                  freightQuoteEntityData?.quoteCourier == null ||
                          freightQuoteEntityData
                                  ?.quoteCourier
                                  .doorDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Courier (Air)",
                        serviceType: "Upto Door",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteCourier.doorDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteCourier.doorDelivery.doorDeliveryTt}",
                        isSelected: selectedShippingIndex == 0,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 0) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 0;
                            }
                          });
                        },
                      ),
                  freightQuoteEntityData?.quoteAir == null ||
                          freightQuoteEntityData
                                  ?.quoteAir
                                  .doorDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Air Freight",
                        serviceType: "Upto Door",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteAir.doorDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteAir.doorDelivery.doorDeliveryTt}",
                        isSelected: selectedShippingIndex == 1,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 1) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 1;
                            }
                          });
                        },
                      ),
                  freightQuoteEntityData?.quoteAir == null ||
                          freightQuoteEntityData
                                  ?.quoteAir
                                  .portDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Air Freight",
                        serviceType: "Upto Port",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteAir.portDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteAir.portDelivery.portDeliveryTt}",
                        isSelected: selectedShippingIndex == 2,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 2) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 2;
                            }
                          });
                        },
                      ),
                  freightQuoteEntityData?.quoteSea == null ||
                          freightQuoteEntityData
                                  ?.quoteSea
                                  .doorDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Sea Freight",
                        serviceType: "Upto Door",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteSea.doorDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteSea.doorDelivery.doorDeliveryTt}",
                        isSelected: selectedShippingIndex == 3,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 3) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 3;
                            }
                          });
                        },
                      ),
                  freightQuoteEntityData?.quoteSea == null ||
                          freightQuoteEntityData
                                  ?.quoteSea
                                  .portDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Sea Freight",
                        serviceType: "Upto Port",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteSea.portDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteSea.portDelivery.portDeliveryTt}",
                        isSelected: selectedShippingIndex == 4,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 4) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 4;
                            }
                          });
                        },
                      ),
                  freightQuoteEntityData?.quoteLand == null ||
                          freightQuoteEntityData
                                  ?.quoteLand
                                  .doorDelivery
                                  .totalAmount ==
                              -1
                      ? SizedBox()
                      : ShippingMethodListItemWidget(
                        label: "Land Freight",
                        serviceType: "Upto Door",
                        shippingFee:
                            "${freightQuoteEntityData?.quoteLand.doorDelivery.totalAmount}",
                        transitEta:
                            "${freightQuoteEntityData?.quoteLand.doorDelivery.doorDeliveryTt}",
                        isSelected: selectedShippingIndex == 5,
                        onTap: () {
                          setModalState(() {
                            if (selectedShippingIndex == 5) {
                              selectedShippingIndex = null;
                            } else {
                              selectedShippingIndex = 5;
                            }
                          });
                        },
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
                        title: 'Apply',
                        color: AppColors.worldGreen,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        onTap: () {
                          if (selectedShippingIndex != null) {
                            _callSelectFreightServiceApi(
                              freightQuoteEntityData!.quoteToken,
                            );
                            context.pop();
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

  void _setLocationWidget() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Location'),
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
                  hintText: 'Complete Address',
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
                  // double lat = double.parse(prediction.lat!);
                  // double lng = double.parse(prediction.lng!);
                  // address = prediction.terms?.first.value ?? "";
                  // final List<Placemark> placemarks = await placemarkFromCoordinates(
                  //   lat,
                  //   lng,
                  // );
                  // countryCode = placemarks[0].isoCountryCode!;
                  _callManualLocationApi(
                    GetManualLocationParams(
                      latitude: double.tryParse(prediction.lat ?? "") ?? 0.0,
                      longitude: double.tryParse(prediction.lng ?? "") ?? 0.0,
                    ),
                  );
                },
                itemClick: (Prediction prediction) {
                  _addCtrl.text = prediction.description!;
                  _addCtrl.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length),
                  );
                  // setState(() {
                  //   address = prediction.terms?.first.value ?? "";
                  // });

                  // context.pop();
                },
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
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

  void _callLocationApi() async {
    await context.read<CartCubit>().getCurrentLocation();
  }

  void _callManualLocationApi(GetManualLocationParams params) async {
    await context.read<CartCubit>().getManualLocation(params);
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
    required LocationEntity location,
  }) {
    final items = cartItems.map((item) => item.toFreightItem()).toList();

    if (items.isNotEmpty) {
      context.read<ShippingCubit>().getFreightQuote(
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

  void _callSelectFreightServiceApi(String quoteToken) {
    context.read<ShippingCubit>().selectFreightService(
      SelectFreightServiceParams(
        quoteToken: quoteToken,
        selectedCourierType: _getCourierType(selectedShippingIndex),
      ),
    );
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

  void _callCalculateInsuranceApi(String quoteToken) {
    context.read<ShippingCubit>().calculateInsurance(
      CalculateInsuranceParams(quoteToken: quoteToken),
    );
  }

  void _callConfirmInsuranceApi({
    required String quoteToken,
    required bool addInsurance,
  }) {
    context.read<ShippingCubit>().confirmInsurance(
      ConfirmInsuranceParams(
        quoteToken: quoteToken,
        addInsurance: addInsurance,
      ),
    );
  }

  bool _callCheckUserLoginApi() {
    return context.read<CommonCubit>().isUserLoggedIn();
  }

  double _calculateLocalTransitFees(List<CartItemEntity> cartItems) {
    double totalTransitFee = 0.0;

    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalTransitFee += item.product.localTransitFee;
      }
    }

    return totalTransitFee;
  }
}
