import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({super.key, required this.categorySlug});

  final String categorySlug;

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  @override
  void initState() {
    _callCategoryListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductCategoryListingEntity> productCategoryList = [];
    return Scaffold(
      // drawer: Drawer(child: _drawer()),
      appBar: AppBar(surfaceTintColor: AppColors.white),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoaded) {
            productCategoryList = state.productCategoryListing;
          } else if (state is CategoryError) {
            widget.showErrorToast(context: context, message: state.error);
          }

          if (state is ProductViewLoaded) {
            context
                .push(AppRoutes.productRoute, extra: state.productEntity)
                .then((_) => _callCategoryListApi());
          } else if (state is CategoryError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          return state is CategoryLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.worldGreen),
              )
              : productCategoryList.isEmpty
              ? Center(child: Text('No items available'))
              : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    width: MediaQuery.of(context).size.width * 0.8,
                    imgUrl: productCategoryList[index].mainImage,
                    itemName: productCategoryList[index].name,
                    regularPrice: productCategoryList[index].regularPrice,
                    salePrice: productCategoryList[index].salePrice,
                    onViewTap: () {
                      context.read<CategoryCubit>().getProductView(
                        ProductViewParams(
                          productId: productCategoryList[index].id,
                        ),
                      );
                    },
                    onCartTap: () {},
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: productCategoryList.length,
              );
        },
      ),
    );
  }

  void _callCategoryListApi() {
    context.read<CategoryCubit>().getProductCategoryList(
      ProductCategoryParams(categorySlug: widget.categorySlug),
    );
  }
}
