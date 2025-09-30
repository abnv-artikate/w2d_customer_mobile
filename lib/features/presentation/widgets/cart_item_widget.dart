import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemEntity cartItem;
  final VoidCallback onCheckBoxTap;
  final VoidCallback onIncrementTap;
  final VoidCallback onDecrementTap;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onCheckBoxTap,
    required this.onIncrementTap,
    required this.onDecrementTap,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.softWhite71),
                child: ClipRRect(
                  child: Image.network(
                    widget.cartItem.product.mainImage,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, obj, stackTrace) {
                      return Center(child: Icon(LucideIcons.imageOff));
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.product.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    // Text(
                    //   widget.cartItem.product.salePrice.toStringAsFixed(2),
                    //   style: TextStyle(fontSize: 18),
                    // ),
                    if (widget.cartItem.product.salePrice <
                        widget.cartItem.product.regularPrice) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CurrencyWidget(
                            price: widget.cartItem.product.salePrice
                                .toStringAsFixed(2),
                            fontSize: 18,
                            svgHeight: 12,
                            svgWidth: 12,
                            fontColor: AppColors.black,
                            strikeThrough: false,
                          ),
                          SizedBox(width: 5),
                          CurrencyWidget(
                            price: widget.cartItem.product.regularPrice
                                .toStringAsFixed(2),
                            fontSize: 16,
                            strikeThrough: true,
                            fontColor: AppColors.softWhite80,
                          ),
                        ],
                      ),
                    ] else ...[
                      CurrencyWidget(
                        price: widget.cartItem.product.regularPrice
                            .toStringAsFixed(2),
                        fontSize: 18,
                        strikeThrough: false,
                      ),
                    ],

                    _incrementWidget(
                      number: widget.cartItem.quantity,
                      onPlusTap: widget.onIncrementTap,
                      onMinusTap: widget.onDecrementTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 1,
            child: InkWell(
              onTap: widget.onCheckBoxTap,
              child: _checkBox(widget.cartItem.isChecked),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBox(bool isChecked) {
    return isChecked
        ? Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.black70),
            color: AppColors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(LucideIcons.check, size: 18, color: AppColors.white),
          ),
        )
        : Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.black70),
          ),
        );
  }

  Widget _incrementWidget({
    required int number,
    VoidCallback? onPlusTap,
    VoidCallback? onMinusTap,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.softWhite71,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(LucideIcons.plus, color: AppColors.black70, size: 15),
              onPressed: onPlusTap,
            ),
          ),
          Text(
            '$number',
            style: TextStyle(fontSize: 20, color: AppColors.black70),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(LucideIcons.minus, color: AppColors.black70, size: 15),
              onPressed: onMinusTap,
            ),
          ),
        ],
      ),
    );
  }
}
