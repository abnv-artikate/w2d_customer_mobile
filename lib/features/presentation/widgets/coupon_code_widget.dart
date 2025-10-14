import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/vouchers/vouchers_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/dashed_border_widget.dart';

class CouponCodeWidget extends StatelessWidget {
  const CouponCodeWidget({
    super.key,
    required this.voucher,
    required this.onApplyTap,
  });

  final VouchersEntity voucher;
  final VoidCallback onApplyTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softWhite80),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(color: AppColors.worldGreen10),
            child: Row(
              children: [
                Icon(Icons.discount, color: AppColors.worldGreen80),
                SizedBox(width: 10),
                Text(
                  voucher.title,
                  style: TextStyle(
                    color: AppColors.worldGreen,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.description,
                  style: TextStyle(
                    color: AppColors.black70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    DashedBorder(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(voucher.code),
                      ),
                    ),
                    Spacer(),
                    CustomFilledButtonWidget(
                      title: Text(
                        "Apply",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      color: Colors.blue,
                      height: 40,
                      onTap: onApplyTap,
                      horizontalPadding: 22,
                      borderRadius: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
