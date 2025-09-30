import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    // required this.width,
    required this.imgUrl,
    required this.itemName,
    required this.regularPrice,
    required this.salePrice,
    required this.onViewTap,
    required this.onWishlistTap,
    this.isGridView = false,
    this.aspectRatio = 1.15,
  });

  // final double width;
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
        // width: width,
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.black70,
          //     blurRadius: 2,
          //   offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child:
            isGridView
                ? _buildGridLayout(context)
                : _buildCarouselLayout(context),
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
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(
            //     // topLeft: Radius.circular(4),
            //     // topRight: Radius.circular(4),
            //     12
            //   ),
            // ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.softWhite71,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(
                    // topLeft: Radius.circular(4),
                    // topRight: Radius.circular(4),
                    //   20
                    // ),
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
                ),
                _buildRatingBadge(),
              ],
            ),
          ),
        ),
        // Content section - Constrained height
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductInfo(),
              if (salePrice.isNotEmpty && salePrice != regularPrice) ...[
                _buildDiscountBadge(),
              ],
              _buildPriceSection(fontSize: 14),
            ],
          ),
        ),
      ],
    );
  }

  // Layout for carousel with fixed dimensions
  Widget _buildCarouselLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image section - Fixed height for carousel
        Expanded(
          flex: 3,
          child: Container(
            // height: double.infinity,
            // width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.softWhite71,
              borderRadius: BorderRadius.circular(
                // topLeft: Radius.circular(4),
                // topRight: Radius.circular(4),
                12,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      // topLeft: Radius.circular(4),
                      // topRight: Radius.circular(4),
                      20,
                    ),
                    child: SizedBox(
                      // width: 250,
                      // height: 250,
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
                  ),
                ),
                _buildRatingBadge(),
              ],
            ),
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
              if (salePrice.isNotEmpty && salePrice != regularPrice) ...[
                _buildDiscountBadge(),
              ],
              SizedBox(height: 4),
              _buildPriceSection(fontSize: 14),
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
          maxLines: 1,
          style: TextStyle(
            fontSize: isGridView ? 14 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Icon(LucideIcons.imageOff, size: 24, color: AppColors.black70),
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
            Text(' | 32', style: TextStyle(fontSize: isGridView ? 8 : 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors.worldGreen10,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '${_calculateDiscount()}% off',
        style: TextStyle(
          fontSize: isGridView ? 10 : 11,
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
          CurrencyWidget(
            price: salePrice,
            fontSize: fontSize,
            strikeThrough: false,
            fontColor: AppColors.worldGreen,
            svgHeight: fontSize * 0.8,
            svgWidth: fontSize * 0.4,
          ),
          SizedBox(width: 4),
          Expanded(
            child: CurrencyWidget(
              price: regularPrice,
              fontSize: fontSize - 2,
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
