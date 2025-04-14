import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/product_item_widget.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({
    super.key,
    this.notchedShape = const CircularNotchedRectangle(),
  });

  final NotchedShape notchedShape;

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  int navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(child: _drawer()),
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemBuilder: (ctx, i) {
          return ProductItemWidget(
            width: MediaQuery.of(context).size.width * 0.8,
          );
        },
        separatorBuilder: (ctx, i) {
          return SizedBox(height: 10);
        },
        itemCount: 25,
      ),
    );
  }
}
