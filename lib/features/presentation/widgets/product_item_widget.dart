import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.width,
    required this.imgUrl,
    required this.itemName,
    required this.regularPrice,
    required this.salePrice,
    required this.onViewTap,
    required this.onWishlistTap,
    this.isGridView = false,
    this.aspectRatio = 1.0,
  });

  final double width;
  final String imgUrl;
  final String itemName;
  final String regularPrice;
  final String salePrice;
  final VoidCallback onViewTap;
  final VoidCallback onWishlistTap;
  final bool isGridView;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black70,
              blurRadius: 2,
              // offset: Offset(0, 2),
            ),
          ],
        ),
        child: isGridView ? _buildGridLayout(context) : _buildCarouselLayout(context),
      ),
    );
  }

  // Layout for grid view with Expanded widgets
  Widget _buildGridLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section - Constrained height for grid
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildErrorWidget();
                    },
                  ),
                ),
                _buildRatingBadge(),
              ],
            ),
          ),
        ),
        // Content section - Constrained height
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductInfo(),
                _buildPriceSection(fontSize: 11),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Layout for carousel with fixed dimensions
  Widget _buildCarouselLayout(BuildContext context) {
    final imageHeight = width * aspectRatio; // Dynamic image height based on width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image section - Fixed height for carousel
        Container(
          height: imageHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildErrorWidget();
                  },
                ),
              ),
              _buildRatingBadge(),
            ],
          ),
        ),
        // Content section - Flexible for carousel
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProductInfo(),
              SizedBox(height: 4),
              _buildPriceSection(fontSize: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          itemName,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: isGridView ? 11 : 12,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
        if (salePrice.isNotEmpty && salePrice != regularPrice) ...[
          SizedBox(height: 4),
          _buildDiscountBadge(),
        ],
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_not_supported,
              size: isGridView ? 24 : 30,
              color: AppColors.black70,
            ),
            SizedBox(height: 4),
            Text(
              'Image unavailable',
              style: TextStyle(
                fontSize: isGridView ? 8 : 10,
                color: AppColors.black70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Positioned(
      bottom: 6,
      left: 6,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isGridView ? 4 : 6,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '4.5',
              style: TextStyle(
                fontSize: isGridView ? 8 : 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 2),
            Image.asset(
              Assets.iconsReviewStartFilled,
              width: isGridView ? 8 : 10,
              height: isGridView ? 8 : 10,
            ),
            Text(
              ' | 32',
              style: TextStyle(fontSize: isGridView ? 8 : 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.worldGreen10,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '${_calculateDiscount()}% off',
        style: TextStyle(
          fontSize: isGridView ? 8 : 9,
          fontWeight: FontWeight.w600,
          color: AppColors.worldGreen,
        ),
      ),
    );
  }

  Widget _buildPriceSection({required double fontSize}) {
    return Row(
      children: [
        if (salePrice.isNotEmpty && salePrice != regularPrice) ...[
          Flexible(
            child: CurrencyWidget(
              price: salePrice,
              fontSize: fontSize,
              strikeThrough: false,
              fontColor: AppColors.worldGreen,
              svgHeight: fontSize * 0.8,
              svgWidth: fontSize * 0.4,
            ),
          ),
          SizedBox(width: 4),
          Flexible(
            child: CurrencyWidget(
              price: regularPrice,
              fontSize: fontSize - 1,
              strikeThrough: true,
              fontColor: AppColors.black70,
              strikeThroughColor: AppColors.black,
              svgHeight: (fontSize - 1) * 0.8,
              svgWidth: (fontSize - 1) * 0.4,
            ),
          ),
        ] else ...[
          Flexible(
            child: CurrencyWidget(
              price: regularPrice,
              fontSize: fontSize,
              strikeThrough: false,
              svgHeight: fontSize * 0.8,
              svgWidth: fontSize * 0.4,
            ),
          ),
        ],
      ],
    );
  }

  int _calculateDiscount() {
    try {
      double sale = double.parse(salePrice);
      double regular = double.parse(regularPrice);
      return (((regular - sale) / regular) * 100).floor();
    } catch (e) {
      return 0;
    }
  }
}