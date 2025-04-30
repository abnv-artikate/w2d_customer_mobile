import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';

class ProductViewEntity {
  String type;
  String status;
  String message;
  ProductViewData data;

  ProductViewEntity({
    required this.type,
    required this.status,
    required this.message,
    required this.data,
  });

}

class ProductViewData {
  String id;
  SellerDetail seller;
  ProductCategoryEntity category;
  dynamic brand;
  List<dynamic> reviews;
  List<dynamic> variations;
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
  ProductViewDimensionsEntity dimensions;
  ProductViewDimensionsEntity packagingDimensions;
  List<ProductViewDimensionsEntity> packagingDetails;
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
  Map<String, dynamic> technicalSpecifications;
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

  ProductViewData({
    required this.id,
    required this.seller,
    required this.category,
    required this.brand,
    required this.reviews,
    required this.variations,
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
  });

}

class ProductViewDimensionsEntity {
  DimensionValues width;
  DimensionValues height;
  DimensionValues length;
  DimensionValues? weight;

  ProductViewDimensionsEntity({
    required this.width,
    required this.height,
    required this.length,
    this.weight,
  });

}

class DimensionValues {
  String unit;
  String value;

  DimensionValues({
    required this.unit,
    required this.value,
  });

}

class SellerDetail {
  int id;
  String businessName;

  SellerDetail({
    required this.id,
    required this.businessName,
  });

}
