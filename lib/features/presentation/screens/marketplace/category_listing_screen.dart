import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/brand_mall_toggle_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';

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

  List<CategoryProductEntity> brandProductCategoryList = [];
  List<CategoryProductEntity> hiddenProductCategoryList = [];

  // bool isBrand = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          brandProductCategoryList = state.brandMallProductCategoryListing;
          hiddenProductCategoryList = state.hiddenGemsProductCategoryListing;
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
        bool isBrand = context.read<CategoryCubit>().isBrand;
        return Scaffold(
          // drawer: Drawer(child: _drawer()),
          appBar: AppBar(
            surfaceTintColor: AppColors.white,
            title: Text(widget.category.name),
            centerTitle: true,
            actions: [
              BrandMallToggleWidget(
                onTap: () {
                  context.read<CategoryCubit>().toggleBrand();
                },
                isBrand: isBrand,
              ),
            ],
          ),
          body:
              state is CategoryLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.worldGreen,
                    ),
                  )
                  : brandProductCategoryList.isEmpty &&
                      hiddenProductCategoryList.isEmpty
                  ? Center(child: Text('No items available'))
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        if (widget.category.subcategories.isNotEmpty) ...[
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 10),
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
                                              widget
                                                  .category
                                                  .subcategories[index],
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
                                      border: Border.all(
                                        color: AppColors.deepBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget
                                            .category
                                            .subcategories[index]
                                            .name,
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
                              imgUrl:
                                  isBrand
                                      ? brandProductCategoryList[index]
                                          .mainImage
                                      : hiddenProductCategoryList[index]
                                          .mainImage,
                              itemName:
                                  isBrand
                                      ? brandProductCategoryList[index]
                                          .productName
                                      : hiddenProductCategoryList[index]
                                          .productName,
                              regularPrice:
                                  isBrand
                                      ? brandProductCategoryList[index]
                                          .regularPrice
                                      : hiddenProductCategoryList[index]
                                          .regularPrice,
                              salePrice:
                                  isBrand
                                      ? brandProductCategoryList[index]
                                          .salePrice
                                      : hiddenProductCategoryList[index]
                                          .salePrice,
                              onViewTap: () {
                                _callProductViewApi(
                                  isBrand
                                      ? brandProductCategoryList[index].id
                                      : hiddenProductCategoryList[index].id,
                                );
                              },
                              onCartTap: () {},
                              onWishlistTap: () {},
                              isHomePage: false,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount:
                              isBrand
                                  ? brandProductCategoryList.length
                                  : hiddenProductCategoryList.length,
                        ),
                      ],
                    ),
                  ),
          bottomNavigationBar: _bottomNavigation(),
        );
      },
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

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }
}
