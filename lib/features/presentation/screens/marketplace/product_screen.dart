import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductViewEntity product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CartSyncLoaded) {
          widget.showErrorToast(context: context, message: state.message);
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [_cartButton()],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _productDetailANdPrice(),
              SizedBox(height: 10),
              _wishlistAndCartButton(),
            ],
          ),
        );
      },
    );
  }

  _cartButton() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: IconButton(
        onPressed: () {},
        icon: Icon(LucideIcons.shoppingCart, size: 30),
      ),
    );
  }

  _productDetailANdPrice() {
    return ListView(
      shrinkWrap: true,
      children: [
        Image.network(
          widget.product.mainImage,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                widget.product.shortDescription,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  if (widget.product.salePrice.isNotEmpty) ...[
                    CurrencyWidget(
                      price: widget.product.salePrice,
                      fontSize: 35,
                      strikeThrough: false,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                    SizedBox(width: 10),
                    CurrencyWidget(
                      price: widget.product.regularPrice,
                      fontSize: 35,
                      strikeThrough: true,
                      fontColor: AppColors.softWhite80,
                      strikeThroughColor: AppColors.softWhite80,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                  ] else ...[
                    CurrencyWidget(
                      price: widget.product.regularPrice,
                      fontSize: 35,
                      strikeThrough: false,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                  ],
                ],
              ),
              if (widget.product.salePrice.isNotEmpty &&
                  widget.product.salePrice != widget.product.regularPrice) ...[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.worldGreen10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${_calculateDiscount()}% off',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  _wishlistAndCartButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlankButtonWidget(
          title: 'Add to Wishlist',
          height: 60,
          width: MediaQuery.of(context).size.width * 0.48,
          onTap: () {},
        ),
        CustomFilledButtonWidget(
          title: 'Add to Cart',
          color: AppColors.worldGreen,
          height: 60,
          width: MediaQuery.of(context).size.width * 0.48,
          onTap: () {
            context.read<CategoryCubit>().cartSync(
              CartSyncParams(productId: widget.product.id, quantity: 1),
            );
          },
        ),
      ],
    );
  }

  int _calculateDiscount() {
    double salePrice = double.parse(widget.product.salePrice);
    double regularPrice = double.parse(widget.product.regularPrice);
    return (((regularPrice - salePrice) / regularPrice) * 100).floor();
  }
}
