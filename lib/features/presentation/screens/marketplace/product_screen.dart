import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductViewEntity product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isWishListed = false;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CartSyncLoaded) {
          widget.showErrorToast(context: context, message: state.message);
          _showAddToCartAnimation();
        } else if (state is CategoryError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        _buildProductInfo(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomActionBar(),
        );
      },
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.width,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: [
        // _buildWishlistButton(),
        _buildCartButton(),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFF8F9FA)],
            ),
          ),
          child: Hero(
            tag: 'product_${widget.product.id}',
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
          ),
        ),
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
            setState(() {
              _isWishListed = !_isWishListed;
            });
            _showWishlistAnimation();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isWishListed ? LucideIcons.heart : LucideIcons.heart,
                key: ValueKey(_isWishListed),
                size: 24,
                color: _isWishListed ? Colors.red : Colors.grey[600],
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black,
          //   blurRadius: 10,
          //   offset: const Offset(0, 2),
          // ),
        ],
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
          const SizedBox(height: 8),
          Text(
            widget.product.shortDescription,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              height: 1.4,
            ),
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
                    onPressed: () {},
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
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
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
            widget.product.shortDescription.isNotEmpty
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

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.product.salePrice.isNotEmpty &&
            widget.product.salePrice != widget.product.regularPrice) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.worldGreen80, AppColors.worldGreen],
              ),
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
          const SizedBox(height: 12),
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
                fontSize: 20,
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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black,
          //   blurRadius: 10,
          //   offset: const Offset(0, -2),
          // ),
        ],
      ),
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
        gradient: LinearGradient(
          colors: [AppColors.worldGreen, AppColors.worldGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // BoxShadow(
          //   color: AppColors.worldGreen,
          //   blurRadius: 8,
          //   offset: const Offset(0, 4),
          // ),
        ],
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

  void _showWishlistAnimation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isWishListed ? LucideIcons.heart : LucideIcons.heartOff,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(_isWishListed ? 'Added to Wishlist' : 'Removed from Wishlist'),
          ],
        ),
        backgroundColor: _isWishListed ? Colors.red : Colors.grey[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddToCartAnimation() {
    // You can implement a more complex animation here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(LucideIcons.check, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('$quantity item(s) added to cart'),
          ],
        ),
        backgroundColor: AppColors.worldGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
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
}
