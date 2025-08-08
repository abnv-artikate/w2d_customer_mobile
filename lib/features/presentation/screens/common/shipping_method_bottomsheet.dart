import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_list_item_widget.dart';

class ShippingMethodBottomSheet extends StatefulWidget {
  const ShippingMethodBottomSheet({super.key});

  @override
  State<ShippingMethodBottomSheet> createState() =>
      _ShippingMethodBottomSheetState();
}

class _ShippingMethodBottomSheetState extends State<ShippingMethodBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartShippingCubit, CartShippingState>(
      builder: (context, state) {
        return _shippingMethodBottomSheet(state);
      },
    );
  }

  _shippingMethodBottomSheet(CartShippingState state) {
    final freightQuoteEntityData = state.freightQuote;
    if (freightQuoteEntityData == null) {
      log("Breaking logic here");
      return;
    }
    int? localSelectedIndex = state.selectedShippingIndex;

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
              child: Column(
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
                        title: 'Apply',
                        color: AppColors.worldGreen,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        onTap: () {
                          if (localSelectedIndex != null) {
                            _callSelectFreightServiceApi(
                              quoteToken: freightQuoteEntityData.quoteToken,
                              serviceIndex: localSelectedIndex,
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

  bool _isShippingOptionAvailable(dynamic deliveryOption) {
    return deliveryOption != null && deliveryOption.totalAmount != -1;
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
}
