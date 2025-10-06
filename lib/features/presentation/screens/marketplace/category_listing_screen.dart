import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({super.key, required this.params});

  final CategoryListingScreenParams params;

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  @override
  void initState() {
    _callCategoryListApi();
    super.initState();
  }

  List<CategoryProductEntity> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          categoryList.clear();
          categoryList = state.categoryListing;
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
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppColors.white,
            title: Text(
              widget.params.category?.name ?? widget.params.searchTerm ?? "",
            ),
            centerTitle: true,
            // actions: [
            //   BrandMallToggleWidget(
            //     onTap: () {
            //       context.read<CategoryCubit>().toggleBrand();
            //     },
            //     isBrand: isBrand,
            //   ),
            // ],
          ),
          body:
              state is CategoryLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.worldGreen,
                    ),
                  )
                  : _buildContent(context),
          bottomNavigationBar: _bottomNavigation(),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Subcategories section
          if (widget.params.category?.subcategories.isNotEmpty ?? false) ...[
            _buildSubcategoriesSection(),
          ],
          // Products grid section
          _buildProductsGrid(context, categoryList),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesSection() {
    return Container(
      height: 60, // Slightly increased for better touch targets
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context
                  .push(
                    AppRoutes.listingRoute,
                    extra: CategoryListingScreenParams(
                      category: widget.params.category?.subcategories[index],
                    ),
                  )
                  .then((_) {
                    _callCategoryListApi();
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.deepBlue, width: 1.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  widget.params.category?.subcategories[index].name ??
                      widget.params.searchTerm ??
                      "",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemCount: widget.params.category?.subcategories.length ?? 0,
      ),
    );
  }

  Widget _buildProductsGrid(
    BuildContext context,
    List<CategoryProductEntity> categoryProductList,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 12.0;
    final crossAxisSpacing = 8.0;

    // Calculate dynamic item width
    // final availableWidth =
    //     screenWidth - (horizontalPadding * 2) - crossAxisSpacing;
    // final itemWidth = availableWidth / 2;

    // Calculate aspect ratio based on screen size
    double aspectRatio;
    if (screenWidth < 400) {
      aspectRatio = 0.5; // Taller items for smaller screens
    } else if (screenWidth < 600) {
      aspectRatio = 0.45; // Medium screens
    } else {
      aspectRatio = 0.4; // Wider items for larger screens
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child:
          categoryProductList.isNotEmpty
              ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 10,
                  childAspectRatio: aspectRatio,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    isGridView: true,
                    imgUrl: categoryProductList[index].mainImage,
                    itemName: categoryProductList[index].productName,
                    regularPrice: categoryProductList[index].regularPrice,
                    salePrice: categoryProductList[index].salePrice,
                    onViewTap: () {
                      _callProductViewApi(categoryProductList[index].id);
                    },
                    onAddButtonTap: () {},
                  );
                },
                itemCount: categoryProductList.length,
              )
              : Center(child: Column(children: [Text("No Items to display")])),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      height: 60, // Increased for better accessibility
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black70,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle filter action
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.filter, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 30, width: 1, color: AppColors.black70),
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle sort action
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.list, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Sort',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callCategoryListApi() {
    context.read<CategoryCubit>().getProductCategoryList(
      ProductCategoryParams(
        categorySlug:
            widget.params.category?.handle ?? widget.params.searchTerm ?? "",
      ),
    );
  }

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }
}

class CategoryListingScreenParams {
  final SubCategoriesEntity? category;
  final String? searchTerm;

  CategoryListingScreenParams({this.category, this.searchTerm});
}
