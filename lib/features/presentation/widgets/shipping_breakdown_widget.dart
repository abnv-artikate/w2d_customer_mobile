import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/shipping_method_dropdown_widget.dart';

class ShippingBreakdownWidget extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  final LocationEntity? location;
  final int? selectedShippingIndex;
  final FreightQuoteEntityData? freightQuoteEntityData;
  final CalculateInsuranceEntity? calculateInsuranceEntity;
  final bool isTransitInsured;
  final VoidCallback onShippingMethodDropdownTap;
  final ValueChanged<bool?>? onTransitInsuranceTap;

  const ShippingBreakdownWidget({
    super.key,
    required this.cartItems,
    required this.onShippingMethodDropdownTap,
    required this.onTransitInsuranceTap,
    this.location,
    this.selectedShippingIndex,
    this.freightQuoteEntityData,
    this.calculateInsuranceEntity,
    this.isTransitInsured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.worldGreen),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Estimated Total:'),
          Text(_calculateEstimatedTotal(cartItems).toStringAsFixed(2)),
          Row(
            children: [
              Text('Select shipping options:'),
              Spacer(),
              ShippingMethodDropdownWidget(
                shippingMethodText: _getShippingMethodName(
                  selectedShippingIndex,
                ),
                onTap: onShippingMethodDropdownTap,
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text('Goods Value'),
              Spacer(),
              Text(_calculateGoodsValue(cartItems).toStringAsFixed(2)),
            ],
          ),
          Row(
            children: [
              Text('Platform Fee'),
              Spacer(),
              Text(_calculatePlatformFees(cartItems).toStringAsFixed(2)),
            ],
          ),
          Row(
            children: [
              Text('Local Transit Fee'),
              Spacer(),
              Text(_calculateLocalTransitFees(cartItems).toStringAsFixed(2)),
            ],
          ),
          Row(
            children: [
              Text('Export Freight / Packing / Other Fees'),
              Spacer(),
              Text(
                _calculateExportFreightPackingOtherFees().toStringAsFixed(2),
              ),
            ],
          ),
          Row(
            children: [
              Text('Dest Duty / Taxes / Other Fees'),
              Spacer(),
              Text(""),
            ],
          ),
          if (calculateInsuranceEntity != null) ...[
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.worldGreen,
                  value: isTransitInsured,
                  onChanged: onTransitInsuranceTap,
                ),
                Text('Transit Insurance'),
                Spacer(),
                Text('${_calculateTransitInsurance()}'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  double _calculateEstimatedTotal(List<CartItemEntity> cartItems) {
    return _calculateGoodsValue(cartItems) +
        _calculatePlatformFees(cartItems) +
        _calculateLocalTransitFees(cartItems) +
        _calculateExportFreightPackingOtherFees() +
        _calculateDestDutyTaxesOtherFees() +
        _calculateTransitInsurance();
  }

  double _calculateGoodsValue(List<CartItemEntity> cartItems) {
    double totalGoodsValue = 0.0;

    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalGoodsValue += double.parse(item.product.salePrice) * item.quantity;
      }
    }

    return totalGoodsValue;
  }

  double _calculatePlatformFees(List<CartItemEntity> cartItems) {
    // platformFee = 0.02 * (productSumTotal + shippingFees + insurance + destinationDuty);
    return calculateInsuranceEntity == null
        ? 0.0
        : (0.02 *
            (_calculateGoodsValue(cartItems) +
                _calculateExportFreightPackingOtherFees() +
                _calculateTransitInsurance() +
                _calculateDestDutyTaxesOtherFees()));
  }

  double _calculateLocalTransitFees(List<CartItemEntity> cartItems) {
    double totalTransitFee = 0.0;

    for (CartItemEntity item in cartItems) {
      if (item.isChecked) {
        totalTransitFee += double.parse(item.product.localTransitFee);
      }
    }

    return totalTransitFee;
  }

  double _calculateExportFreightPackingOtherFees() {
    return calculateInsuranceEntity?.data.freightAmount ?? 0.0;
  }

  double _calculateDestDutyTaxesOtherFees() {
    return 0.0;
  }

  double _calculateTransitInsurance() {
    return calculateInsuranceEntity?.data.insuranceAmt ?? 0.0;
  }

  String _getShippingMethodName(int? shippingIndex) {
    switch (shippingIndex) {
      case 0:
        return "Courier (air)";
      case 1:
        return "Air Freight (door)";
      case 2:
        return "Air Freight (port)";
      case 3:
        return "Sea Freight (door)";
      case 4:
        return "Sea Freight (port)";
      case 5:
        return "Land Freight (door)";
      default:
        return "Select Shipping Method";
    }
  }
}
