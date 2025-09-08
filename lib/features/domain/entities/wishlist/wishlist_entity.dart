class WishListEntity {
  final String status;
  final WishListDataEntity data;

  WishListEntity({required this.status, required this.data});
}

class WishListDataEntity {
  final int id;
  final int customer;
  final String createdAt;
  final List<WishListDataItemEntity> items;

  WishListDataEntity({
    required this.id,
    required this.customer,
    required this.createdAt,
    required this.items,
  });
}

class WishListDataItemEntity {
  final int id;
  final int wishlist;
  final WishListDataItemProductEntity product;
  final dynamic variant;
  final String addedAt;

  WishListDataItemEntity({
    required this.id,
    required this.wishlist,
    required this.product,
    required this.variant,
    required this.addedAt,
  });
}

class WishListDataItemProductEntity {
  final String id;
  final String name;
  final String sku;
  final dynamic modelNumber;
  final String productType;
  final String badge;
  final String shortDescription;
  final String longDescription;
  final dynamic keyFeatures;
  final String mainImage;
  final List<String> gallery;
  final dynamic videoUrl;
  final String regularPrice;
  final String localTransitFee;
  final String salePrice;
  final dynamic currency;
  final int availableStock;
  final int lowStockAlert;
  final dynamic purchaseLimit;
  final String commissionPercentage;
  final String weight;
  final String weightUnit;
  final dynamic shippingWeight;
  final String shippingWeightUnit;
  final WishListDataItemProductDimensionsEntity dimensions;
  final dynamic packagingDimensions;
  final List<WishListDataItemProductPackagingDetailEntity> packagingDetails;
  final String shippingMethods;
  final String shippingRegion;
  final List<String> shippingCountries;
  final String handlingTime;
  final dynamic returnsPolicy;
  final dynamic tags;
  final dynamic seoTitle;
  final dynamic metaDescription;
  final String status;
  final dynamic publishDate;
  final String visibility;
  final dynamic specificCustomerGroups;
  final dynamic lastUpdatedBy;
  final bool hasVariant;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;
  final bool selfFulfilled;
  final String countryOfOrigin;
  final String hsCode;
  final bool isMarketplace;
  final bool isActive;
  final String createdAt;
  final String lastUpdatedAt;
  final int seller;
  final WishListDataItemProductCategoryEntity category;
  final int brand;

  WishListDataItemProductEntity({
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
    required this.hasVariant,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.selfFulfilled,
    required this.countryOfOrigin,
    required this.hsCode,
    required this.isMarketplace,
    required this.isActive,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.seller,
    required this.category,
    required this.brand,
  });
}

class WishListDataItemProductCategoryEntity {
  final int id;
  final String name;
  final int parent;
  final List<dynamic> subcategories;
  final WishListDataItemProductCategoryAllowedAttributesEntity
  allowedAttributes;

  WishListDataItemProductCategoryEntity({
    required this.id,
    required this.name,
    required this.parent,
    required this.subcategories,
    required this.allowedAttributes,
  });
}

class WishListDataItemProductCategoryAllowedAttributesEntity {
  final List<String> form;
  final List<String> size;
  final List<String> duration;
  final List<String> skinType;
  final List<String> scentFamily;
  final List<String> alcoholContent;

  WishListDataItemProductCategoryAllowedAttributesEntity({
    required this.form,
    required this.size,
    required this.duration,
    required this.skinType,
    required this.scentFamily,
    required this.alcoholContent,
  });
}

class WishListDataItemProductDimensionsEntity {
  final WishlistMeasurement width;
  final WishlistMeasurement height;
  final WishlistMeasurement length;

  WishListDataItemProductDimensionsEntity({
    required this.width,
    required this.height,
    required this.length,
  });
}

class WishlistMeasurement {
  final String unit;
  final double value;

  WishlistMeasurement({required this.unit, required this.value});
}

class WishListDataItemProductPackagingDetailEntity {
  final WishlistMeasurement width;
  final WishlistMeasurement height;
  final WishlistMeasurement length;
  final WishlistMeasurement weight;
  final String woodenBoxPackaging;

  WishListDataItemProductPackagingDetailEntity({
    required this.width,
    required this.height,
    required this.length,
    required this.weight,
    required this.woodenBoxPackaging,
  });
}
