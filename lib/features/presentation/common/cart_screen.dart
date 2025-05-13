import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/cart_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/cart_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_dropdown_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    callGetCartItemApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String shippingMethod = "";
    List<CartItemEntity> cartItems = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        actions: [
          ShippingMethodDropdownWidget(
            shippingMethodText: shippingMethod,
            onTap: () {
              _shippingMethodBottomSheet();
            },
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemLoaded) {
            cartItems = state.cartItems;
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
                    _checkoutButton(),
                  ],
                ),
              );
        },
      ),
    );
  }

  Widget _checkoutButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.worldGreen,
      ),
      child: Text(
        'Proceed to buy',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 28,
        ),
      ),
    );
  }

  void callGetCartItemApi() {
    context.read<CartCubit>().getCartItems();
  }

  _shippingMethodBottomSheet() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) {
        return Container(child: ListView(children: []));
      },
    );
  }
}
