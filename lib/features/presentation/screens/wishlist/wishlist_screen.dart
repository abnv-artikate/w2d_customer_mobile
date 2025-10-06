import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/wishlist/wishlist_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<WishListDataItemEntity> items = [];

  @override
  void initState() {
    _callGetWishlistApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      aspectRatio = 0.65; // Taller items for smaller screens
    } else if (screenWidth < 600) {
      aspectRatio = 0.7; // Medium screens
    } else {
      aspectRatio = 0.75; // Wider items for larger screens
    }
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetWishListLoaded) {
          items.clear();
          items = state.wishListEntity.data.items;
        } else if (state is GetWishListError) {
          widget.showErrorToast(context: context, message: state.error);
        }

        if (state is ProductViewLoaded) {
          context
              .push(AppRoutes.productRoute, extra: state.productEntity)
              .then((_) => _callGetWishlistApi());
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body:
              state is GetWishListLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.worldGreen,
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: GridView.builder(
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
                          // width: itemWidth,
                          isGridView: true,
                          imgUrl: items[index].product.mainImage,
                          itemName: items[index].product.name,
                          regularPrice: items[index].product.regularPrice,
                          salePrice: items[index].product.salePrice,
                          onViewTap: () {
                            _callProductViewApi(items[index].product.id);
                          },
                          onAddButtonTap: () {},
                        );
                      },
                      itemCount: items.length,
                    ),
                  ),
        );
      },
    );
  }

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }

  void _callGetWishlistApi() {
    context.read<CategoryCubit>().getWishList();
  }
}
