import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';

extension CartEntityExtension on CartEntity {
  List<CartItemEntity> get checkedItems =>
      items.where((i) => i.isChecked).toList(growable: false);

  List<Items> toFreightItems() =>
      checkedItems
          .map((i) => i.toFreightItem())
          .whereType<Items>()
          .toList(growable: false);

  String get shippingItemsHash =>
      checkedItems
          .map(
            (i) => '${i.product.id}:${i.variant?.hashCode ?? "_"}:${i
            .quantity}:1',
      )
          .join('|');

  double get checkedGoodsValue =>
      checkedItems.fold<double>(
        0.0,
            (sum, i) => sum + i.product.effectivePrice * i.quantity,
      );

  bool get hasCheckedItems => checkedItems.isNotEmpty;
}
