import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';

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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black70),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Image.network(
                  widget.cartItem.product.mainImage,
                  width: 80,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.product.name,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.cartItem.product.salePrice,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            child: InkWell(
              onTap: widget.onCheckBoxTap,
              child: _checkBox(widget.cartItem.isChecked),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 1,
            child: _incrementWidget(
              number: widget.cartItem.quantity,
              onPlusTap: widget.onIncrementTap,
              onMinusTap: widget.onDecrementTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBox(bool isChecked) {
    return isChecked
        ? Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.black70),
            color: AppColors.black,
          ),
          child: Icon(LucideIcons.check, size: 30, color: AppColors.white),
        )
        : Container(
          height: 30,
          width: 30,
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
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.worldGreen),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                LucideIcons.plus,
                color: AppColors.worldGreen,
                size: 20,
              ),
              onPressed: onPlusTap,
            ),
          ),
          Text(
            '$number',
            style: TextStyle(fontSize: 25, color: AppColors.worldGreen),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                LucideIcons.minus,
                color: AppColors.worldGreen,
                size: 20,
              ),
              onPressed: onMinusTap,
            ),
          ),
        ],
      ),
    );
  }
}
