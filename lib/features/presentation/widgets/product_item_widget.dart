import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
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
    required this.isHomePage,
  });

  final double width;
  final String imgUrl;
  final String itemName;

  // final String itemDescription;
  final String regularPrice;
  final String salePrice;
  final VoidCallback onViewTap;
  final VoidCallback onCartTap;
  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isHomePage ? onViewTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          // border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black70,
              blurRadius: 2,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
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
                  Positioned(
                    bottom: 2,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.white,
                      ),
                      child: Row(
                        children: [
                          Text('4.5', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 5),
                          Image.asset(Assets.iconsReviewStartFilled),
                          Text(' | 32', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              itemName,
              style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                if (salePrice.isNotEmpty && salePrice != regularPrice) ...[
                  CurrencyWidget(
                    price: salePrice,
                    fontSize: 15,
                    strikeThrough: false,
                  ),
                  SizedBox(width: 5,),
                  CurrencyWidget(
                    price: regularPrice,
                    fontSize: 15,
                    strikeThrough: true,
                    fontColor: AppColors.black70,
                    strikeThroughColor: AppColors.black,
                  ),
                ] else ...[
                  CurrencyWidget(
                    price: regularPrice,
                    fontSize: 15,
                    strikeThrough: false,
                  ),
                ],
              ],
            ),
            if (!isHomePage) ...[
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
          ],
        ),
      ),
    );
  }
}
