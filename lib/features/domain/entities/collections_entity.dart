class CollectionsEntity {
  final int count;
  final dynamic next;
  final dynamic previous;
  final CollectionsResultEntity results;

  CollectionsEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

class CollectionsResultEntity {
  final String status;
  final String message;
  final List<CollectionsResultDataEntity> data;

  CollectionsResultEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class CollectionsResultDataEntity {
  final String id;
  final List<CollectionsResultDataProductEntity> products;
  final String name;
  final String slug;
  final String collectionType;
  final String description;
  final String backgroundImage;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  CollectionsResultDataEntity({
    required this.id,
    required this.products,
    required this.name,
    required this.slug,
    required this.collectionType,
    required this.description,
    required this.backgroundImage,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}

class CollectionsResultDataProductEntity {
  final String id;

  // final Seller seller;
  // final Category category;
  // final Brand brand;
  final List<dynamic> reviews;

  // final List<Variation> variations;
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
  final int purchaseLimit;
  final String commissionPercentage;
  final String weight;
  final String weightUnit;
  final dynamic shippingWeight;
  final String shippingWeightUnit;

  // final ProductDimensions dimensions;
  // final PackagingDimensions packagingDimensions;
  // final List<PackagingDetail> packagingDetails;
  final String shippingMethods;
  final String shippingRegion;
  final List<String> shippingCountries;
  final String handlingTime;
  final String returnsPolicy;
  final String tags;
  final dynamic seoTitle;
  final String metaDescription;
  final String status;
  final dynamic publishDate;
  final String visibility;
  final dynamic specificCustomerGroups;
  final dynamic lastUpdatedBy;

  // final ProductTechnicalSpecifications technicalSpecifications;
  final bool hasVariant;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;
  final String countryOfOrigin;
  final String hsCode;
  final bool isActive;
  final String createdAt;
  final String lastUpdatedAt;

  CollectionsResultDataProductEntity({
    required this.id,
    // required this.seller,
    // required this.category,
    // required this.brand,
    required this.reviews,
    // required this.variations,
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
    // required this.dimensions,
    // required this.packagingDimensions,
    // required this.packagingDetails,
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
    // required this.technicalSpecifications,
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

// class Brand {
//   final int id;
//   final String name;
//   final dynamic description;
//
//   Brand({
//     required this.id,
//     required this.name,
//     required this.description,
//   });
//
// }
//
// class Subcategory {
//   final int id;
//   final String name;
//   final int parent;
//   final List<Category> subcategories;
//   final Map<String, List<String>> allowedAttributes;
//
//   Subcategory({
//     required this.id,
//     required this.name,
//     required this.parent,
//     required this.subcategories,
//     required this.allowedAttributes,
//   });
//
// }
//
// class Category {
//   final int id;
//   final String name;
//   final int parent;
//   final List<Subcategory> subcategories;
//   final AllowedAttributes allowedAttributes;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.parent,
//     required this.subcategories,
//     required this.allowedAttributes,
//   });
//
// }
//
// class AllowedAttributes {
//   final List<String> size;
//   final List<String> color;
//   final List<String> wattage;
//   final List<String> material;
//   final List<String> switchType;
//   final List<String> lightSourceType;
//   final List<String> topNotes;
//   final List<String> baseNotes;
//   final List<String> heartNotes;
//   final List<String> lensType;
//   final List<String> frameShape;
//   final List<String> lensMaterial;
//   final List<String> uvProtection;
//   final List<String> brand;
//   final Notes notes;
//   final List<String> season;
//   final List<String> sillage;
//   final List<String> occasion;
//   final List<String> longevity;
//   final List<String> bottleDesign;
//   final List<String> concentration;
//   final List<String> fragranceFamily;
//   final List<String> chairDimensions;
//   final List<String> seatingCapacity;
//   final List<String> tableDimensions;
//   final List<String> weightCapacity;
//   final List<String> cushionIncluded;
//   final List<String> firmness;
//   final List<String> dimensions;
//   final List<String> mattressType;
//
//   AllowedAttributes({
//     required this.size,
//     required this.color,
//     required this.wattage,
//     required this.material,
//     required this.switchType,
//     required this.lightSourceType,
//     required this.topNotes,
//     required this.baseNotes,
//     required this.heartNotes,
//     required this.lensType,
//     required this.frameShape,
//     required this.lensMaterial,
//     required this.uvProtection,
//     required this.brand,
//     required this.notes,
//     required this.season,
//     required this.sillage,
//     required this.occasion,
//     required this.longevity,
//     required this.bottleDesign,
//     required this.concentration,
//     required this.fragranceFamily,
//     required this.chairDimensions,
//     required this.seatingCapacity,
//     required this.tableDimensions,
//     required this.weightCapacity,
//     required this.cushionIncluded,
//     required this.firmness,
//     required this.dimensions,
//     required this.mattressType,
//   });
//
// }
//
// class Notes {
//   final List<String> topNotes;
//   final List<String> baseNotes;
//   final List<String> middleNotes;
//
//   Notes({
//     required this.topNotes,
//     required this.baseNotes,
//     required this.middleNotes,
//   });
//
// }
//
// class ProductDimensions {
//   final PurpleHeight width;
//   final PurpleHeight height;
//   final PurpleHeight length;
//
//   ProductDimensions({
//     required this.width,
//     required this.height,
//     required this.length,
//   });
//
// }
//
// class PurpleHeight {
//   final String unit;
//   final dynamic value;
//
//   PurpleHeight({
//     required this.unit,
//     required this.value,
//   });
//
// }
//
// class PackagingDetail {
//   final PurpleHeight width;
//   final PurpleHeight height;
//   final PurpleHeight length;
//   final PurpleHeight weight;
//   final String woodenBoxPackaging;
//
//   PackagingDetail({
//     required this.width,
//     required this.height,
//     required this.length,
//     required this.weight,
//     required this.woodenBoxPackaging,
//   });
//
// }
//
// class PackagingDimensions {
//   final PackagingDimensionsHeight width;
//   final PackagingDimensionsHeight height;
//   final PackagingDimensionsHeight length;
//
//   PackagingDimensions({
//     required this.width,
//     required this.height,
//     required this.length,
//   });
//
// }
//
// class PackagingDimensionsHeight {
//   final String unit;
//   final String value;
//
//   PackagingDimensionsHeight({
//     required this.unit,
//     required this.value,
//   });
//
// }
//
// class Seller {
//   final int id;
//   final String businessName;
//
//   Seller({
//     required this.id,
//     required this.businessName,
//   });
//
// }
//
// class ProductTechnicalSpecifications {
//   final String topNotes;
//   final String heartNotes;
//   final String lensType;
//   final String frameShape;
//   final String lensMaterial;
//   final String uvProtection;
//   final String material;
//   final String chairDimensions;
//   final String seatingCapacity;
//   final String tableDimensions;
//
//   ProductTechnicalSpecifications({
//     required this.topNotes,
//     required this.heartNotes,
//     required this.lensType,
//     required this.frameShape,
//     required this.lensMaterial,
//     required this.uvProtection,
//     required this.material,
//     required this.chairDimensions,
//     required this.seatingCapacity,
//     required this.tableDimensions,
//   });
//
// }
//
// class Variation {
//   final String id;
//   final String size;
//   final String color;
//   final dynamic material;
//   final dynamic style;
//   final dynamic count;
//   final dynamic capacity;
//   final dynamic powerConsumption;
//   final dynamic voltage;
//   final dynamic packSize;
//   final dynamic expirationDate;
//   final dynamic energyRating;
//   final dynamic warrantyPeriod;
//   final dynamic pattern;
//   final dynamic occasion;
//   final String name;
//   final String sku;
//   final dynamic modelNumber;
//   final String mainImage;
//   final List<dynamic> gallery;
//   final dynamic videoUrl;
//   final String regularPrice;
//   final String salePrice;
//   final dynamic currency;
//   final int availableStock;
//   final int lowStockAlert;
//   final dynamic purchaseLimit;
//   final String weight;
//   final String weightUnit;
//   final dynamic shippingWeight;
//   final String shippingWeightUnit;
//   final PackagingDetailClass dimensions;
//   final dynamic packagingDimensions;
//   final List<PackagingDetailClass> packagingDetails;
//   final String shippingMethods;
//   final String shippingRegion;
//   final dynamic shippingCountries;
//   final String handlingTime;
//   final dynamic tags;
//   final dynamic seoTitle;
//   final dynamic metaDescription;
//   final String status;
//   final dynamic publishDate;
//   final String visibility;
//   final dynamic specificCustomerGroups;
//   final bool woodenBoxPackaging;
//   final bool isPerfume;
//   final bool containsBattery;
//   final bool isCosmetics;
//   final bool containsMagnet;
//   final dynamic countryOfOrigin;
//   final dynamic hsCode;
//   final dynamic lastUpdatedBy;
//   final VariationTechnicalSpecifications technicalSpecifications;
//   final bool isActive;
//   final String createdAt;
//   final String lastUpdatedAt;
//   final String product;
//
//   Variation({
//     required this.id,
//     required this.size,
//     required this.color,
//     required this.material,
//     required this.style,
//     required this.count,
//     required this.capacity,
//     required this.powerConsumption,
//     required this.voltage,
//     required this.packSize,
//     required this.expirationDate,
//     required this.energyRating,
//     required this.warrantyPeriod,
//     required this.pattern,
//     required this.occasion,
//     required this.name,
//     required this.sku,
//     required this.modelNumber,
//     required this.mainImage,
//     required this.gallery,
//     required this.videoUrl,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.currency,
//     required this.availableStock,
//     required this.lowStockAlert,
//     required this.purchaseLimit,
//     required this.weight,
//     required this.weightUnit,
//     required this.shippingWeight,
//     required this.shippingWeightUnit,
//     required this.dimensions,
//     required this.packagingDimensions,
//     required this.packagingDetails,
//     required this.shippingMethods,
//     required this.shippingRegion,
//     required this.shippingCountries,
//     required this.handlingTime,
//     required this.tags,
//     required this.seoTitle,
//     required this.metaDescription,
//     required this.status,
//     required this.publishDate,
//     required this.visibility,
//     required this.specificCustomerGroups,
//     required this.woodenBoxPackaging,
//     required this.isPerfume,
//     required this.containsBattery,
//     required this.isCosmetics,
//     required this.containsMagnet,
//     required this.countryOfOrigin,
//     required this.hsCode,
//     required this.lastUpdatedBy,
//     required this.technicalSpecifications,
//     required this.isActive,
//     required this.createdAt,
//     required this.lastUpdatedAt,
//     required this.product,
//   });
//
// }
//
// class PackagingDetailClass {
//   final FluffyHeight width;
//   final FluffyHeight height;
//   final FluffyHeight length;
//   final FluffyHeight weight;
//
//   PackagingDetailClass({
//     required this.width,
//     required this.height,
//     required this.length,
//     required this.weight,
//   });
//
// }
//
// class FluffyHeight {
//   final String unit;
//   final int value;
//
//   FluffyHeight({
//     required this.unit,
//     required this.value,
//   });
//
// }
//
// class VariationTechnicalSpecifications {
//   VariationTechnicalSpecifications();
// }
