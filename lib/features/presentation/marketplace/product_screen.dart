import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/core/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productEntity});

  final ProductViewEntity productEntity;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: _backButton(),
        actions: [_likeButton()],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          _productDetailANdPrice(),
          SizedBox(height: 10),
          _wishlistAndCartButton(),
          SizedBox(height: 10),
        ],
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          widget.productEntity.mainImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
        Text(
          widget.productEntity.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Text(
          widget.productEntity.shortDescription,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Text(
              '\u{20B9}${widget.productEntity.regularPrice}',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.softWhite80,
                color: AppColors.softWhite80,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '\u{20B9}${widget.productEntity.salePrice}',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
          ],
        ),
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
              CartSyncParams(productId: widget.productEntity.id, quantity: 1),
            );
          },
        ),
      ],
    );
  }

  int _calculateDiscount() {
    double salePrice = double.parse(widget.productEntity.salePrice);
    double regularPrice = double.parse(widget.productEntity.regularPrice);
    return ((salePrice / regularPrice) * 100).ceil();
  }
}
