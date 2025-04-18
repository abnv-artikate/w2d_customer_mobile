import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/core/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class ProductItemWidget extends StatelessWidget {
  final double width;

  const ProductItemWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final String img =
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80';
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
                img,
                fit: BoxFit.cover,
                width: width,
                errorBuilder: (context, widget, stack) {
                  return Center(child: Text('Image not available'));
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sofa 3+2+1 Set',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                '(Grey, DIY (Do-It-Yourself)',
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text.rich(
                TextSpan(
                  text: '',
                  children: <TextSpan>[
                    TextSpan(
                      text: '\u{20B9}1499/-',
                      style: TextStyle(
                        color: AppColors.black70,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.black,
                        fontFamily: 'CormorantGaramond',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' \u{20B9}999/-',
                      style: TextStyle(
                        fontFamily: 'CormorantGaramond',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlankButtonWidget(
                title: 'View',
                fontSize: 14,
                borderRadius: 4,
                height: 30,
                width: width * 0.45,
                onTap: () {
                  context.push(AppRoutes.productRoute);
                },
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
                  onTap: () {
                    context.push(AppRoutes.listingRoute);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
