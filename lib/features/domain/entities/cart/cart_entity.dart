import 'package:equatable/equatable.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';

abstract class Entity extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartEntity extends Entity {
  final int id;
  final dynamic customer;
  final String sessionKey;
  final DateTime createdAt;
  final List<CartItemEntity> items;

   CartEntity({
    required this.id,
    required this.customer,
    required this.sessionKey,
    required this.createdAt,
    required this.items,
  });

  List<CartItemEntity> get checkedItems =>
      items.where((item) => item.isChecked).toList();

  List<CartItemEntity> get shippableItems =>
      checkedItems.where((item) => item.isValidForShipping).toList();

  double get totalValue => checkedItems.fold(
    0.0,
        (sum, item) => sum + item.totalPrice,
  );

  int get totalQuantity => checkedItems.fold(
    0,
        (sum, item) => sum + item.quantity,
  );

  int get checkedItemsCount => checkedItems.length;

  @override
  List<Object?> get props => [id, customer, sessionKey, createdAt, items];

  CartEntity copyWith({
    int? id,
    dynamic customer,
    String? sessionKey,
    DateTime? createdAt,
    List<CartItemEntity>? items,
  }) {
    return CartEntity(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      sessionKey: sessionKey ?? this.sessionKey,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
    );
  }
}

class CartItemEntity extends Entity {
  final int id;
  final int cart;
  final CartItemProductEntity product;
  final CartItemVariantEntity? variant;
  final int quantity;
  final String? voucherCode;
  final double discountAmount;
  final DateTime addedAt;
  final bool isChecked;

   CartItemEntity({
    required this.id,
    required this.cart,
    required this.product,
    this.variant,
    required this.quantity,
    this.voucherCode,
    required this.discountAmount,
    required this.addedAt,
    required this.isChecked,
  });

  double get unitPrice => variant?.effectivePrice ?? product.effectivePrice;
  double get totalPrice => unitPrice * quantity;
  double get totalDiscountedPrice => totalPrice - discountAmount;
  bool get isValidForShipping => product.isShippable && quantity > 0;
  bool get hasVariant => variant != null;

  CartItemShippingInfoEntity get shippingInfo => CartItemShippingInfoEntity(
    attributes: variant?.attributes ?? product.attributes,
    packagingDetails: variant?.packagingDetails ?? product.packagingDetails,
    hsCode: variant?.hsCode ?? product.hsCode,
    weight: variant?.weight ?? product.weight,
  );

  @override
  List<Object?> get props => [
    id, cart, product, variant, quantity,
    voucherCode, discountAmount, addedAt, isChecked
  ];

  CartItemEntity copyWith({
    int? id,
    int? cart,
    CartItemProductEntity? product,
    CartItemVariantEntity? variant,
    int? quantity,
    String? voucherCode,
    double? discountAmount,
    DateTime? addedAt,
    bool? isChecked,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      cart: cart ?? this.cart,
      product: product ?? this.product,
      variant: variant ?? this.variant,
      quantity: quantity ?? this.quantity,
      voucherCode: voucherCode ?? this.voucherCode,
      discountAmount: discountAmount ?? this.discountAmount,
      addedAt: addedAt ?? this.addedAt,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

class CartItemProductEntity extends Entity {
  final String id;
  final String name;
  final String sku;
  final String? modelNumber;
  final ProductType productType;
  final String badge;
  final String shortDescription;
  final String longDescription;
  final List<String> keyFeatures;
  final String mainImage;
  final List<String> gallery;
  final String? videoUrl;
  final double regularPrice;
  final double localTransitFee;
  final double salePrice;
  final String currency;
  final int availableStock;
  final int lowStockAlert;
  final int purchaseLimit;
  final double? commissionPercentage;
  final MeasurementEntity weight;
  final MeasurementEntity? shippingWeight;
  final CartItemProductDimensionsEntity dimensions;
  final CartItemProductDimensionsEntity packagingDimensions;
  final List<CartItemProductDimensionsEntity> packagingDetails;
  final List<ShippingMethod> shippingMethods;
  final String shippingRegion;
  final List<String> shippingCountries;
  final Duration handlingTime;
  final String? returnsPolicy;
  final List<String> tags;
  final String? seoTitle;
  final String? metaDescription;
  final ProductStatus status;
  final DateTime? publishDate;
  final ProductVisibility visibility;
  final List<String> specificCustomerGroups;
  final String? lastUpdatedBy;
  final Map<String, dynamic> technicalSpecifications;
  final ProductAttributesEntity attributes;
  final String countryOfOrigin;
  final String? hsCode;
  final bool isActive;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;
  final int seller;
  final CartItemProductCategoryEntity? category;
  final int brand;

   CartItemProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    this.modelNumber,
    required this.productType,
    required this.badge,
    required this.shortDescription,
    required this.longDescription,
    required this.keyFeatures,
    required this.mainImage,
    required this.gallery,
    this.videoUrl,
    required this.regularPrice,
    required this.localTransitFee,
    required this.salePrice,
    required this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    this.commissionPercentage,
    required this.weight,
    this.shippingWeight,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    this.returnsPolicy,
    required this.tags,
    this.seoTitle,
    this.metaDescription,
    required this.status,
    this.publishDate,
    required this.visibility,
    required this.specificCustomerGroups,
    this.lastUpdatedBy,
    required this.technicalSpecifications,
    required this.attributes,
    required this.countryOfOrigin,
    this.hsCode,
    required this.isActive,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.seller,
    this.category,
    required this.brand,
  });

  double get effectivePrice => salePrice > 0 ? salePrice : regularPrice;
  bool get isOnSale => salePrice > 0 && salePrice < regularPrice;
  bool get isInStock => availableStock > 0;
  bool get isLowStock => availableStock <= lowStockAlert;
  bool get isShippable => status == ProductStatus.active && isActive;
  String get shippingAttribute => attributes.getShippingAttribute();
  bool get hasValidDimensions => packagingDetails.any((detail) => detail.isValid);

  @override
  List<Object?> get props => [
    id, name, sku, modelNumber, productType, badge, shortDescription,
    longDescription, keyFeatures, mainImage, gallery, videoUrl, regularPrice,
    localTransitFee, salePrice, currency, availableStock, lowStockAlert,
    purchaseLimit, commissionPercentage, weight, shippingWeight, dimensions,
    packagingDimensions, packagingDetails, shippingMethods, shippingRegion,
    shippingCountries, handlingTime, returnsPolicy, tags, seoTitle,
    metaDescription, status, publishDate, visibility, specificCustomerGroups,
    lastUpdatedBy, technicalSpecifications, attributes, countryOfOrigin,
    hsCode, isActive, createdAt, lastUpdatedAt, seller, category, brand,
  ];
}

class CartItemVariantEntity extends Entity {
  final String? size;
  final String? color;
  final String? material;
  final String? style;
  final String? name;
  final String? sku;
  final String? modelNumber;
  final String? mainImage;
  final double? regularPrice;
  final double? salePrice;
  final String currency;
  final int? availableStock;
  final MeasurementEntity? weight;
  final List<CartItemProductDimensionsEntity>? packagingDetails;
  final ProductAttributesEntity attributes;
  final String? hsCode;
  final bool isActive;

   CartItemVariantEntity({
    this.size,
    this.color,
    this.material,
    this.style,
    this.name,
    this.sku,
    this.modelNumber,
    this.mainImage,
    this.regularPrice,
    this.salePrice,
    required this.currency,
    this.availableStock,
    this.weight,
    this.packagingDetails,
    required this.attributes,
    this.hsCode,
    required this.isActive,
  });

  double get effectivePrice =>
      (salePrice != null && salePrice! > 0) ? salePrice! : (regularPrice ?? 0.0);

  @override
  List<Object?> get props => [
    size, color, material, style, name, sku, modelNumber, mainImage,
    regularPrice, salePrice, currency, availableStock, weight,
    packagingDetails, attributes, hsCode, isActive,
  ];
}

class CartItemProductCategoryEntity extends Entity {
  final int id;
  final String name;
  final int? parent;
  final List<dynamic> subcategories;
  final dynamic allowedAttributes;

   CartItemProductCategoryEntity({
    required this.id,
    required this.name,
    this.parent,
    required this.subcategories,
    this.allowedAttributes,
  });

  @override
  List<Object?> get props => [id, name, parent, subcategories, allowedAttributes];
}

class CartItemProductDimensionsEntity extends Entity {
  final MeasurementEntity width;
  final MeasurementEntity height;
  final MeasurementEntity length;
  final MeasurementEntity weight;

   CartItemProductDimensionsEntity({
    required this.width,
    required this.height,
    required this.length,
    required this.weight,
  });

  bool get isValid =>
      width.value > 0 && height.value > 0 && length.value > 0 && weight.value > 0;

  double get volume => width.value * height.value * length.value;

  @override
  List<Object> get props => [width, height, length, weight];
}

class MeasurementEntity extends Entity {
  final String unit;
  final double value;

   MeasurementEntity({
    required this.unit,
    required this.value,
  });

  @override
  List<Object> get props => [unit, value];

  @override
  String toString() => '$value $unit';
}

class ProductAttributesEntity extends Entity {
  final bool hasVariant;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;

   ProductAttributesEntity({
    required this.hasVariant,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
  });

  String getShippingAttribute() {
    if (isCosmetics) return "cosmetics";
    if (isPerfume) return "perfumes";
    if (containsBattery) return "battery";
    if (containsMagnet) return "magnet";
    return "";
  }

  bool get hasSpecialShippingRequirements =>
      isPerfume || containsBattery || isCosmetics || containsMagnet;

  @override
  List<Object> get props => [
    hasVariant, woodenBoxPackaging, isPerfume,
    containsBattery, isCosmetics, containsMagnet,
  ];
}

class CartItemShippingInfoEntity extends Entity {
  final ProductAttributesEntity attributes;
  final List<CartItemProductDimensionsEntity> packagingDetails;
  final String? hsCode;
  final MeasurementEntity weight;

   CartItemShippingInfoEntity({
    required this.attributes,
    required this.packagingDetails,
    this.hsCode,
    required this.weight,
  });

  @override
  List<Object?> get props => [attributes, packagingDetails, hsCode, weight];
}

enum ProductType {
  electronics,
  clothing,
  books,
  home,
  beauty,
  sports,
  toys,
  automotive,
  other;

  static ProductType fromString(String value) {
    return ProductType.values.firstWhere(
          (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ProductType.other,
    );
  }
}

enum ProductStatus {
  active,
  inactive,
  pending,
  discontinued;

  static ProductStatus fromString(String value) {
    return ProductStatus.values.firstWhere(
          (status) => status.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ProductStatus.inactive,
    );
  }
}

enum ProductVisibility {
  public,
  private,
  restricted;

  static ProductVisibility fromString(String value) {
    return ProductVisibility.values.firstWhere(
          (visibility) => visibility.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ProductVisibility.public,
    );
  }
}

enum ShippingMethod {
  air,
  sea,
  land,
  express;

  static ShippingMethod fromString(String value) {
    return ShippingMethod.values.firstWhere(
          (method) => method.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ShippingMethod.air,
    );
  }
}

// Extensions for freight quote integration
extension CartItemEntityFreightExtensions on CartItemEntity {
  Items? toFreightItem() {
    if (!isChecked || !isValidForShipping) return null;

    try {
      final dimensions = product.packagingDetails
          .where((detail) => detail.isValid)
          .map((detail) => detail.toDimension(product.attributes.woodenBoxPackaging))
          .toList();

      if (dimensions.isEmpty) return null;

      return Items(
        itemsGoods: (product.effectivePrice * quantity).toString(),
        itemDescription: product.productType.name,
        noOfPkgs: dimensions.length,
        attribute: product.shippingAttribute,
        hsCode: product.hsCode ?? "",
        dimensions: dimensions,
      );
    } catch (e) {
      // Log error appropriately
      return null;
    }
  }
}

extension CartItemProductDimensionsEntityFreightExtensions on CartItemProductDimensionsEntity {
  Dimensions toDimension(bool woodenBoxPackaging) {
    return Dimensions(
      kiloGrams: weight.value,
      length: length.value,
      width: width.value,
      height: height.value,
      addWoodenPacking: woodenBoxPackaging,
    );
  }
}