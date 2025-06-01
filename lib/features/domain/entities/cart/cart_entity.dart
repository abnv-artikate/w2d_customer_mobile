class CartEntity {
  int id;
  dynamic customer;
  String sessionKey;
  String createdAt;
  List<CartItemEntity> items;

  CartEntity({
    required this.id,
    required this.customer,
    required this.sessionKey,
    required this.createdAt,
    required this.items,
  });
}

class CartItemEntity {
  int id;
  int cart;
  CartItemProductEntity product;

  // VariantEntity variant;
  int quantity;
  dynamic voucherCode;
  String discountAmount;
  String addedAt;
  bool isChecked;

  CartItemEntity({
    required this.id,
    required this.cart,
    required this.product,
    // required this.variant,
    required this.quantity,
    required this.voucherCode,
    required this.discountAmount,
    required this.addedAt,
    required this.isChecked,
  });
}

class CartItemProductEntity {
  String id;
  String name;
  String sku;
  dynamic modelNumber;
  String productType;
  String badge;
  String shortDescription;
  String longDescription;
  dynamic keyFeatures;
  String mainImage;
  List<String> gallery;
  dynamic videoUrl;
  String regularPrice;
  String localTransitFee;
  String salePrice;
  dynamic currency;
  int availableStock;
  int lowStockAlert;
  int purchaseLimit;
  dynamic commissionPercentage;
  String weight;
  String weightUnit;
  dynamic shippingWeight;
  String shippingWeightUnit;
  CartItemProductDimensionsEntity dimensions;
  CartItemProductDimensionsEntity packagingDimensions;
  List<CartItemProductDimensionsEntity> packagingDetails;
  String shippingMethods;
  String shippingRegion;
  List<String> shippingCountries;
  String handlingTime;
  dynamic returnsPolicy;
  dynamic tags;
  dynamic seoTitle;
  dynamic metaDescription;
  String status;
  dynamic publishDate;
  String visibility;
  dynamic specificCustomerGroups;
  dynamic lastUpdatedBy;
  dynamic technicalSpecifications;
  bool hasVariant;
  bool woodenBoxPackaging;
  bool isPerfume;
  bool containsBattery;
  bool isCosmetics;
  bool containsMagnet;
  String countryOfOrigin;
  dynamic hsCode;
  bool isActive;
  String createdAt;
  String lastUpdatedAt;
  int seller;
  // Category category;
  int brand;

  CartItemProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.modelNumber,
    required this.productType,
    required this.badge,
    required this.shortDescription,
    required this.longDescription,
    required this.keyFeatures,
    required this.mainImage,
    required this.gallery,
    required this.videoUrl,
    required this.regularPrice,
    required this.localTransitFee,
    required this.salePrice,
    required this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    required this.commissionPercentage,
    required this.weight,
    required this.weightUnit,
    required this.shippingWeight,
    required this.shippingWeightUnit,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    required this.returnsPolicy,
    required this.tags,
    required this.seoTitle,
    required this.metaDescription,
    required this.status,
    required this.publishDate,
    required this.visibility,
    required this.specificCustomerGroups,
    required this.lastUpdatedBy,
    required this.technicalSpecifications,
    required this.hasVariant,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.countryOfOrigin,
    required this.hsCode,
    required this.isActive,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.seller,
    // required this.category,
    required this.brand,
  });
}

class CartItemProductCategoryEntity {
  int id;
  String name;
  int parent;
  List<dynamic> subcategories;
  dynamic allowedAttributes;

  CartItemProductCategoryEntity({
    required this.id,
    required this.name,
    required this.parent,
    required this.subcategories,
    required this.allowedAttributes,
  });
}

class CartItemProductDimensionsEntity {
  DimensionEntity width;
  DimensionEntity height;
  DimensionEntity length;
  DimensionEntity weight;

  CartItemProductDimensionsEntity({
    required this.width,
    required this.height,
    required this.length,
    required this.weight,
  });
}

class DimensionEntity {
  String unit;
  String value;

  DimensionEntity({required this.unit, required this.value});
}

class VariantEntity {
  String size;
  String color;
  String material;
  String style;
  dynamic count;
  String capacity;
  String powerConsumption;
  String voltage;
  String packSize;
  dynamic expirationDate;
  String energyRating;
  String warrantyPeriod;
  String pattern;
  String occasion;
  String name;
  String sku;
  String modelNumber;
  String mainImage;
  dynamic gallery;
  String videoUrl;
  dynamic regularPrice;
  dynamic salePrice;
  String currency;
  dynamic availableStock;
  dynamic lowStockAlert;
  dynamic purchaseLimit;
  dynamic weight;
  dynamic weightUnit;
  dynamic shippingWeight;
  dynamic shippingWeightUnit;
  dynamic dimensions;
  dynamic packagingDimensions;
  dynamic packagingDetails;
  dynamic shippingMethods;
  dynamic shippingRegion;
  dynamic shippingCountries;
  String handlingTime;
  String tags;
  String seoTitle;
  String metaDescription;
  dynamic status;
  dynamic publishDate;
  dynamic visibility;
  dynamic specificCustomerGroups;
  bool woodenBoxPackaging;
  bool isPerfume;
  bool containsBattery;
  bool isCosmetics;
  bool containsMagnet;
  String countryOfOrigin;
  String hsCode;
  String lastUpdatedBy;
  dynamic technicalSpecifications;
  bool isActive;
  dynamic product;

  VariantEntity({
    required this.size,
    required this.color,
    required this.material,
    required this.style,
    required this.count,
    required this.capacity,
    required this.powerConsumption,
    required this.voltage,
    required this.packSize,
    required this.expirationDate,
    required this.energyRating,
    required this.warrantyPeriod,
    required this.pattern,
    required this.occasion,
    required this.name,
    required this.sku,
    required this.modelNumber,
    required this.mainImage,
    required this.gallery,
    required this.videoUrl,
    required this.regularPrice,
    required this.salePrice,
    required this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    required this.weight,
    required this.weightUnit,
    required this.shippingWeight,
    required this.shippingWeightUnit,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    required this.tags,
    required this.seoTitle,
    required this.metaDescription,
    required this.status,
    required this.publishDate,
    required this.visibility,
    required this.specificCustomerGroups,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.countryOfOrigin,
    required this.hsCode,
    required this.lastUpdatedBy,
    required this.technicalSpecifications,
    required this.isActive,
    required this.product,
  });
}
