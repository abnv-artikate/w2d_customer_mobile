import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/currency_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_dropdown_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';

class FeesBreakdownWidget extends StatelessWidget {
  final VoidCallback? onShippingMethodDropdownTap;

  const FeesBreakdownWidget({super.key, this.onShippingMethodDropdownTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.worldGreen),
        borderRadius: BorderRadius.circular(4),
      ),
      child: BlocBuilder<CartShippingCubit, CartShippingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEstimatedTotal(context, state),
              SizedBox(height: 30),
              _buildShippingMethodSelector(context, state),
              SizedBox(height: 30),
              _buildFeeBreakdown(context, state),
            ],
          );
        },
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
            // Text(
            //   '${state.feeBreakdown!.estimatedTotal.toStringAsFixed(2)}',
            //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //     color: AppColors.worldGreen,
            //     fontWeight: FontWeight.bold,
            //   ),
            // )
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
            // Text(
            //   '\$0.00',
            //   style: Theme.of(
            //     context,
            //   ).textTheme.headlineSmall?.copyWith(color: Colors.grey),
            // ),
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
        // border: Border.all(color: AppColors.worldGreen80),
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
            onTap: onShippingMethodDropdownTap ?? () {},
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
            _buildFeeRow(context, 'Platform Fee', breakdown.platformFees),
            _buildFeeRow(
              context,
              'Local Transit Fee',
              breakdown.localTransitFees,
            ),
            _buildFeeRow(
              context,
              'Export Freight / Packing / Other Fees',
              breakdown.exportFreightPackingOtherFees,
            ),
            _buildFeeRow(
              context,
              'Dest Duty / Taxes / Other Fees',
              breakdown.destDutyTaxesOtherFees,
            ),
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
      return Column(
        children: [
          _buildLoadingFeeRow(context, 'Goods Value'),
          _buildLoadingFeeRow(context, 'Platform Fee'),
          _buildLoadingFeeRow(context, 'Local Transit Fee'),
          _buildLoadingFeeRow(context, 'Export Freight / Packing / Other Fees'),
          _buildLoadingFeeRow(context, 'Dest Duty / Taxes / Other Fees'),
          if (state.hasInsuranceData) ...[
            _buildLoadingTransitInsuranceRow(context, state),
          ],
        ],
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
              // overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          // Text(
          //   '${amount.toStringAsFixed(2)}',
          //   style: Theme.of(
          //     context,
          //   ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          // ),
          CurrencyWidget(
            price: amount.toStringAsFixed(2),
            fontSize: 15,
            strikeThrough: false,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingFeeRow(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.worldGreen),
            ),
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
          // Text(
          //   '\$${amount.toStringAsFixed(2)}',
          //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //     fontWeight: FontWeight.w500,
          //     color: state.isTransitInsured ? null : Colors.grey,
          //   ),
          // ),
          CurrencyWidget(
            price: amount.toStringAsFixed(2),
            fontSize: 14,
            strikeThrough: false,
            fontColor: state.isTransitInsured ? null : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingTransitInsuranceRow(
    BuildContext context,
    CartShippingState state,
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
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.worldGreen),
            ),
          ),
        ],
      ),
    );
  }
}
