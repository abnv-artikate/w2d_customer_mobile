import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.width,
    required this.imgUrl,
    required this.itemName,
    // required this.itemDescription,
    required this.regularPrice,
    required this.salePrice,
    required this.onViewTap,
    required this.onCartTap,
  });

  final double width;
  final String imgUrl;
  final String itemName;

  // final String itemDescription;
  final String regularPrice;
  final String salePrice;
  final VoidCallback onViewTap;
  final VoidCallback onCartTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      padding: EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imgUrl,
                fit: BoxFit.contain,
                width: width,
                height: width,
                errorBuilder: (context, widget, stack) {
                  return SizedBox(
                    height: 120,
                    child: Center(child: Text('Image not available')),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(Assets.iconsReviewStartFilled),
              SizedBox(width: 5),
              Text(
                '32 reviews',
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            itemName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(
                '\u{20B9}$regularPrice',
                style: TextStyle(
                  color: AppColors.black70,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.black,
                  fontFamily: 'CormorantGaramond',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                ' \u{20B9}$salePrice',
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlankButtonWidget(
                title: 'View',
                fontSize: 14,
                borderRadius: 4,
                height: 30,
                width: width * 0.45,
                onTap: onViewTap,
              ),
              SizedBox(width: 5),
              Expanded(
                child: CustomFilledButtonWidget(
                  title: 'Add to Cart',
                  color: AppColors.worldGreen,
                  fontSize: 14,
                  borderRadius: 4,
                  height: 30,
                  width: width * 0.45,
                  onTap: onCartTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
