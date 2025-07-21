import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    _callProductViewApi(widget.productId);
    super.initState();
  }

  ProductViewEntity? product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CartSyncLoaded) {
          widget.showErrorToast(context: context, message: state.message);
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }

        if (state is ProductViewLoaded) {
          product = state.productEntity;
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 80,
            leading: product != null ? _backButton() : null,
            actions: [product != null ? _likeButton() : null],
          ),
          body:
              product == null
                  ? Center(child: Text('Error occurred while loading product'))
                  : Column(
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

  _backButton() {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white,
        ),
        child: Center(child: Icon(LucideIcons.arrowLeft, size: 30)),
      ),
    );
  }

  _likeButton() {
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
          product!.mainImage,
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
                product!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                product!.shortDescription,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  if (product!.salePrice.isNotEmpty) ...[
                    CurrencyWidget(
                      price: product!.salePrice,
                      fontSize: 35,
                      strikeThrough: false,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                    SizedBox(width: 10),
                    CurrencyWidget(
                      price: product!.regularPrice,
                      fontSize: 35,
                      strikeThrough: true,
                      fontColor: AppColors.softWhite80,
                      strikeThroughColor: AppColors.softWhite80,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                  ] else ...[
                    CurrencyWidget(
                      price: product!.regularPrice,
                      fontSize: 35,
                      strikeThrough: false,
                      svgHeight: 20,
                      svgWidth: 10,
                    ),
                  ],
                ],
              ),
              if (product!.salePrice.isNotEmpty &&
                  product!.salePrice != product!.regularPrice) ...[
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
              CartSyncParams(productId: product!.id, quantity: 1),
            );
          },
        ),
      ],
    );
  }

  int _calculateDiscount() {
    double salePrice = double.parse(product!.salePrice);
    double regularPrice = double.parse(product!.regularPrice);
    return (((regularPrice - salePrice) / regularPrice) * 100).floor();
  }

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }
}
