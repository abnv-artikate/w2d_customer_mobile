import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/recommendations/recommendations_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/related_products/related_products_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/add_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductViewEntity product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isWishListed = false;
  int quantity = 1;

  CarouselOptions get _imageCarouselOption {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic height calculation based on screen size
    double carouselHeight;
    if (screenWidth < 400) {
      carouselHeight =
          screenHeight * 0.25; // 32% of screen height for small devices
    } else if (screenWidth < 600) {
      carouselHeight = screenHeight * 0.28; // 35% for medium devices
    } else {
      carouselHeight = screenHeight * 0.32; // 38% for larger devices
    }

    return CarouselOptions(
      disableCenter: true,
      padEnds: false,
      height: carouselHeight,
      viewportFraction: 1,
      enableInfiniteScroll: false,
    );
  }

  CarouselOptions get _recommendationsAndRelatedProductsCarouselOption {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic height calculation based on screen size
    double carouselHeight;
    if (screenWidth < 400) {
      carouselHeight =
          screenHeight * 0.25; // 32% of screen height for small devices
    } else if (screenWidth < 600) {
      carouselHeight = screenHeight * 0.28; // 35% for medium devices
    } else {
      carouselHeight = screenHeight * 0.32; // 38% for larger devices
    }

    return CarouselOptions(
      disableCenter: true,
      padEnds: false,
      height: carouselHeight,
      viewportFraction: screenWidth < 400 ? 0.55 : 0.5,
      enableInfiniteScroll: false,
    );
  }

  List<RecommendationsDataEntity> recommendations = [];
  List<RelatedProductsDataEntity> relatedProducts = [];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    final cubit = context.read<CategoryCubit>();

    cubit.getRecommendation(widget.product.id);
    cubit.getRelatedProducts(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CartSyncLoaded) {
          widget.showErrorToast(context: context, message: state.message);
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }

        if (state is RecommendationsLoaded) {
          recommendations = state.recommendationsEntity.data;
        } else if (state is RelatedProductsLoaded) {
          relatedProducts = state.relatedProductsEntity.data;
        } else if (state is RecommendationsError) {
          widget.showErrorToast(context: context, message: state.error);
        } else if (state is RelatedProductsError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(actions: [_buildCartButton()]),
          body: SafeArea(
            bottom: true,
            child: ListView(
              children: [
                _buildProductImage(),
                _buildProductInfo(),
                recommendations.isNotEmpty ? _buildRecommendations() : Container(),
                relatedProducts.isNotEmpty ? _buildRelatedProducts() : Container(),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomActionBar(),
        );
      },
    );
  }

  Widget _buildProductImage() {
    return widget.product.gallery.isNotEmpty
        ? Container(
          decoration: BoxDecoration(),
          child: CarouselSlider(
            options: _imageCarouselOption,
            items:
                widget.product.gallery.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Image not available',
                                style: TextStyle(color: AppColors.black70),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
          ),
        )
        : Container(
          decoration: const BoxDecoration(),
          child: Image.network(
            widget.product.mainImage,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                  color: AppColors.worldGreen,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(
                  LucideIcons.image,
                  size: 64,
                  color: Colors.grey,
                ),
              );
            },
          ),
        );
  }

  Widget _buildWishlistButton() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            _callAddWishListApi();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isWishListed ? LucideIcons.heart : LucideIcons.heart,
                key: ValueKey(isWishListed),
                size: 24,
                color: isWishListed ? Colors.red : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              LucideIcons.shoppingCart,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.product.shortDescription,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              height: 1.4,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 20),
          _buildPriceSection(),
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.softWhite80),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                    icon: Icon(
                      LucideIcons.plus,
                      color: AppColors.black70,
                      size: 15,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity += 1;
                      });
                    },
                  ),
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 20, color: AppColors.black70),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                    icon: Icon(
                      LucideIcons.minus,
                      color: AppColors.black70,
                      size: 15,
                    ),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity -= 1;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(LucideIcons.info, size: 20, color: AppColors.worldGreen),
              const SizedBox(width: 8),
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.product.longDescription.isNotEmpty
                ? widget.product.longDescription
                : 'Premium quality product with excellent features and craftsmanship.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  _buildRecommendations() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Products",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          CarouselSlider(
            options: _recommendationsAndRelatedProductsCarouselOption,
            items:
                recommendations
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductItemWidget(
                          width: MediaQuery.of(context).size.width,
                          imgUrl: e.mainImage,
                          itemName: e.name,
                          regularPrice: e.regularPrice,
                          salePrice: e.salePrice,
                          onViewTap: () {},
                          onWishlistTap: () {},
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  _buildRelatedProducts() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Related Products",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          CarouselSlider(
            options: _recommendationsAndRelatedProductsCarouselOption,
            items:
                relatedProducts
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductItemWidget(
                          width: MediaQuery.of(context).size.width,
                          imgUrl: e.mainImage,
                          itemName: e.name,
                          regularPrice: e.regularPrice,
                          salePrice: e.salePrice,
                          onViewTap: () {},
                          onWishlistTap: () {},
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.product.salePrice.isNotEmpty &&
            widget.product.salePrice != widget.product.regularPrice) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.worldGreen80,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_calculateDiscount()}% OFF',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.product.salePrice.isNotEmpty &&
                widget.product.salePrice != widget.product.regularPrice) ...[
              CurrencyWidget(
                price: widget.product.salePrice,
                fontSize: 32,
                strikeThrough: false,
                svgHeight: 20,
                svgWidth: 10,
              ),
              const SizedBox(width: 12),
              CurrencyWidget(
                price: widget.product.regularPrice,
                fontSize: 30,
                strikeThrough: true,
                fontColor: Colors.grey[500],
                strikeThroughColor: Colors.grey[500],
                svgHeight: 16,
                svgWidth: 8,
              ),
            ] else ...[
              CurrencyWidget(
                price: widget.product.regularPrice,
                fontSize: 32,
                strikeThrough: false,
                svgHeight: 20,
                svgWidth: 10,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 1, child: _buildWishlistButton()),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: _buildAddToCartButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.worldGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<CategoryCubit>().cartSync(
              CartSyncParams(productId: widget.product.id, quantity: quantity),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.shoppingCart, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _calculateDiscount() {
    if (widget.product.salePrice.isEmpty ||
        widget.product.regularPrice.isEmpty) {
      return 0;
    }
    try {
      double salePrice = double.parse(widget.product.salePrice);
      double regularPrice = double.parse(widget.product.regularPrice);
      return (((regularPrice - salePrice) / regularPrice) * 100).floor();
    } catch (e) {
      return 0;
    }
  }

  void _callAddWishListApi() {
    context.read<CategoryCubit>().addWishList(
      AddWishListParams(productId: widget.product.id),
    );
  }
}
