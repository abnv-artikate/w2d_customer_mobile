import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/brand_mall_toggle_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({super.key, required this.category});

  final SubCategoriesEntity category;

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
    List<ResultEntity> productCategoryList = [];
    bool isBrand = false;
    return Scaffold(
      // drawer: Drawer(child: _drawer()),
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: Text(widget.category.name),
        centerTitle: true,
        actions: [BrandMallToggleWidget(onTap: () {}, isBrand: isBrand)],
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoaded) {
            productCategoryList = state.productCategoryListing;
          } else if (state is CategoryError) {
            widget.showErrorToast(context: context, message: state.error);
          }

          // if (state is ProductViewLoaded) {
          //   context
          //       .push(AppRoutes.productRoute, extra: state.productEntity)
          //       .then((_) => _callCategoryListApi());
          // } else if (state is CategoryError) {
          //   widget.showErrorToast(context: context, message: state.error);
          // }
        },
        builder: (context, state) {
          return state is CategoryLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.worldGreen),
              )
              : productCategoryList.isEmpty
              ? Center(child: Text('No items available'))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.category.subcategories.isNotEmpty) ...[
                      Container(
                        height: 50,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context
                                    .push(
                                      AppRoutes.listingRoute,
                                      extra:
                                          widget.category.subcategories[index],
                                    )
                                    .then((_) {
                                      _callCategoryListApi();
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.deepBlue),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.category.subcategories[index].name,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 5);
                          },
                          itemCount: widget.category.subcategories.length,
                        ),
                      ),
                    ],
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                          width: MediaQuery.of(context).size.width * 0.8,
                          imgUrl: productCategoryList[index].mainImage,
                          itemName: productCategoryList[index].productName,
                          regularPrice: productCategoryList[index].regularPrice,
                          salePrice: productCategoryList[index].salePrice,
                          onViewTap: () {
                            context
                                .push(
                                  AppRoutes.productRoute,
                                  extra: productCategoryList[index].id,
                                )
                                .then((_) => _callCategoryListApi());
                          },
                          onCartTap: () {},
                          isHomePage: false,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: productCategoryList.length,
                    ),
                  ],
                ),
              );
        },
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  _bottomNavigation() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(LucideIcons.filter),
              SizedBox(width: 8),
              Text('Filter', style: TextStyle(fontSize: 18)),
            ],
          ),
          VerticalDivider(),
          Row(
            children: [
              Icon(LucideIcons.list),
              SizedBox(width: 8),
              Text('Sort', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  void _callCategoryListApi() {
    context.read<CategoryCubit>().getProductCategoryList(
      ProductCategoryParams(categorySlug: widget.category.handle),
    );
  }

  // void _callProductViewApi(String productId) {
  //   context.read<CategoryCubit>().getProductView(
  //     ProductViewParams(productId: productId),
  //   );
  // }
}
