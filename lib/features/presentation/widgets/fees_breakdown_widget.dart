import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_dropdown_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';

class FeesBreakdownWidget extends StatefulWidget {
  final VoidCallback? onShippingMethodDropdownTap;
  final VoidCallback? onViewAvailableOffersTap;

  const FeesBreakdownWidget({
    super.key,
    this.onShippingMethodDropdownTap,
    this.onViewAvailableOffersTap,
  });

  @override
  State<FeesBreakdownWidget> createState() => _FeesBreakdownWidgetState();
}

class _FeesBreakdownWidgetState extends State<FeesBreakdownWidget> {
  final TextEditingController _voucherController = TextEditingController();
  final FocusNode _voucherNode = FocusNode();

  @override
  void dispose() {
    _voucherController.dispose();
    _voucherNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: BlocBuilder<CartShippingCubit, CartShippingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVoucherSection(context, state),
              SizedBox(height: 30),
              _buildFeeBreakdown(context, state),
              SizedBox(height: 30),
              _buildShippingMethodSelector(context, state),
              SizedBox(height: 30),
              _buildEstimatedTotal(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVoucherSection(BuildContext context, CartShippingState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.softWhite71,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _voucherController,
                  focusNode: _voucherNode,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.softWhite80),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.worldGreen,
                        width: 2,
                      ),
                    ),
                    hintText: 'Enter Voucher Code',
                    hintStyle: TextStyle(
                      color: AppColors.softWhite80,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                  cursorColor: AppColors.black,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  onTapOutside: (_) {
                    _voucherNode.unfocus();
                  },
                ),
              ),
              SizedBox(width: 10),
              CustomFilledButtonWidget(
                title: Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                color: AppColors.worldGreen80,
                height: 48,
                onTap: () {},
                borderRadius: 8,
                horizontalPadding: 25,
              ),
            ],
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: widget.onViewAvailableOffersTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.discount, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "View Available Offers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Spacer(),
                  Icon(LucideIcons.chevronRight, color: Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstimatedTotal(BuildContext context, CartShippingState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.softWhite71,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estimated Total:',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          if (state.hasFeeBreakdown)
            CurrencyWidget(
              price: state.feeBreakdown!.estimatedTotal.toStringAsFixed(2),
              fontSize: 20,
              strikeThrough: false,
              svgHeight: 12,
              svgWidth: 12,
              fontColor: AppColors.worldGreen,
            )
          else if (state.isFeeCalculationLoading)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.worldGreen,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text('Calculating...'),
              ],
            )
          else
            CurrencyWidget(
              price: "0.00",
              fontSize: 20,
              strikeThrough: false,
              svgHeight: 12,
              svgWidth: 12,
              fontColor: AppColors.softWhite71,
            ),
        ],
      ),
    );
  }

  Widget _buildShippingMethodSelector(
    BuildContext context,
    CartShippingState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.softWhite71,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Select shipping options:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(width: 10),
          ShippingMethodDropdownWidget(
            shippingMethodText: context
                .read<CartShippingCubit>()
                .getShippingMethodName(state.selectedShippingIndex),
            onTap: widget.onShippingMethodDropdownTap ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFeeBreakdown(BuildContext context, CartShippingState state) {
    if (state.hasFeeBreakdown) {
      final breakdown = state.feeBreakdown!;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.softWhite71,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Breakdown",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            _buildFeeRow(context, 'Goods Value', breakdown.goodsValue),
            if (breakdown.platformFees != 0.0) ...[
              _buildFeeRow(context, 'Platform Fee', breakdown.platformFees),
            ],
            if (breakdown.localTransitFees != 0.0) ...[
              _buildFeeRow(
                context,
                'Local Transit Fee',
                breakdown.localTransitFees,
              ),
            ],
            if (breakdown.exportFreightPackingOtherFees != 0.0) ...[
              _buildFeeRow(
                context,
                'Export Freight / Packing / Other Fees',
                breakdown.exportFreightPackingOtherFees,
              ),
            ],
            if (breakdown.destDutyTaxesOtherFees != 0.0) ...[
              _buildFeeRow(
                context,
                'Dest Duty / Taxes / Other Fees',
                breakdown.destDutyTaxesOtherFees,
              ),
            ],
            if (state.hasInsuranceData) ...[
              _buildTransitInsuranceRow(
                context,
                state,
                breakdown.transitInsurance,
              ),
            ],
          ],
        ),
      );
    } else if (state.isFeeCalculationLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.worldGreen80),
      );
    } else if (state.hasError &&
        state.feeCalculationStatus == LoadingStatus.error) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 8),
            Text(
              'Error calculating fees',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              state.errorMessage ?? 'Unknown error occurred',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<CartShippingCubit>().getCartItems();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.worldGreen,
              ),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          _buildFeeRow(context, 'Goods Value', 0.0),
          _buildFeeRow(context, 'Platform Fee', 0.0),
          _buildFeeRow(context, 'Local Transit Fee', 0.0),
          _buildFeeRow(context, 'Export Freight / Packing / Other Fees', 0.0),
          _buildFeeRow(context, 'Dest Duty / Taxes / Other Fees', 0.0),
        ],
      );
    }
  }

  Widget _buildFeeRow(BuildContext context, String label, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
          ),
          CurrencyWidget(
            price: amount.toStringAsFixed(2),
            fontSize: 15,
            strikeThrough: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTransitInsuranceRow(
    BuildContext context,
    CartShippingState state,
    double amount,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.worldGreen,
            value: state.isTransitInsured,
            onChanged: (value) {
              if (value != null) {
                context.read<CartShippingCubit>().updateTransitInsurance(value);
              }
            },
          ),
          Expanded(
            child: Text(
              'Transit Insurance',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CurrencyWidget(
            price: amount.toStringAsFixed(2),
            fontSize: 14,
            strikeThrough: false,
          ),
        ],
      ),
    );
  }
}
