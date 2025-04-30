import 'dart:convert';

class ProductViewModel {
  String? type;
  String? status;
  String? message;
  Data? data;

  ProductViewModel({this.type, this.status, this.message, this.data});

  factory ProductViewModel.fromRawJson(String str) =>
      ProductViewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductViewModel.fromJson(Map<String, dynamic> json) =>
      ProductViewModel(
        type: json["type"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  Seller? seller;
  Category? category;
  dynamic brand;
  List<dynamic>? reviews;
  List<dynamic>? variations;
  String? name;
  String? sku;
  dynamic modelNumber;
  String? productType;
  String? badge;
  String? shortDescription;
  String? longDescription;
  dynamic keyFeatures;
  String? mainImage;
  List<String>? gallery;
  dynamic videoUrl;
  String? regularPrice;
  String? localTransitFee;
  String? salePrice;
  dynamic currency;
  int? availableStock;
  int? lowStockAlert;
  int? purchaseLimit;
  dynamic commissionPercentage;
  String? weight;
  String? weightUnit;
  dynamic shippingWeight;
  String? shippingWeightUnit;
  Dimensions? dimensions;
  Dimensions? packagingDimensions;
  List<Dimensions>? packagingDetails;
  String? shippingMethods;
  String? shippingRegion;
  List<String>? shippingCountries;
  String? handlingTime;
  dynamic returnsPolicy;
  dynamic tags;
  dynamic seoTitle;
  dynamic metaDescription;
  String? status;
  dynamic publishDate;
  String? visibility;
  dynamic specificCustomerGroups;
  dynamic lastUpdatedBy;

  // TechnicalSpecifications? technicalSpecifications;
  bool? hasVariant;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  String? countryOfOrigin;
  dynamic hsCode;
  bool? isActive;
  String? createdAt;
  String? lastUpdatedAt;

  Data({
    this.id,
    this.seller,
    this.category,
    this.brand,
    this.reviews,
    this.variations,
    this.name,
    this.sku,
    this.modelNumber,
    this.productType,
    this.badge,
    this.shortDescription,
    this.longDescription,
    this.keyFeatures,
    this.mainImage,
    this.gallery,
    this.videoUrl,
    this.regularPrice,
    this.localTransitFee,
    this.salePrice,
    this.currency,
    this.availableStock,
    this.lowStockAlert,
    this.purchaseLimit,
    this.commissionPercentage,
    this.weight,
    this.weightUnit,
    this.shippingWeight,
    this.shippingWeightUnit,
    this.dimensions,
    this.packagingDimensions,
    this.packagingDetails,
    this.shippingMethods,
    this.shippingRegion,
    this.shippingCountries,
    this.handlingTime,
    this.returnsPolicy,
    this.tags,
    this.seoTitle,
    this.metaDescription,
    this.status,
    this.publishDate,
    this.visibility,
    this.specificCustomerGroups,
    this.lastUpdatedBy,
    // this.technicalSpecifications,
    this.hasVariant,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.countryOfOrigin,
    this.hsCode,
    this.isActive,
    this.createdAt,
    this.lastUpdatedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"],
    reviews:
        json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    variations:
        json["variations"] == null
            ? []
            : List<dynamic>.from(json["variations"]!.map((x) => x)),
    name: json["name"],
    sku: json["sku"],
    modelNumber: json["model_number"],
    productType: json["product_type"],
    badge: json["badge"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    keyFeatures: json["key_features"],
    mainImage: json["main_image"],
    gallery:
        json["gallery"] == null
            ? []
            : List<String>.from(json["gallery"]!.map((x) => x)),
    videoUrl: json["video_url"],
    regularPrice: json["regular_price"],
    localTransitFee: json["local_transit_fee"],
    salePrice: json["sale_price"],
    currency: json["currency"],
    availableStock: json["available_stock"],
    lowStockAlert: json["low_stock_alert"],
    purchaseLimit: json["purchase_limit"],
    commissionPercentage: json["commission_percentage"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    shippingWeight: json["shipping_weight"],
    shippingWeightUnit: json["shipping_weight_unit"],
    dimensions:
        json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
    packagingDimensions:
        json["packaging_dimensions"] == null
            ? null
            : Dimensions.fromJson(json["packaging_dimensions"]),
    packagingDetails:
        json["packaging_details"] == null
            ? []
            : List<Dimensions>.from(
              json["packaging_details"]!.map((x) => Dimensions.fromJson(x)),
            ),
    shippingMethods: json["shipping_methods"],
    shippingRegion: json["shipping_region"],
    shippingCountries:
        json["shipping_countries"] == null
            ? []
            : List<String>.from(json["shipping_countries"]!.map((x) => x)),
    handlingTime: json["handling_time"],
    returnsPolicy: json["returns_policy"],
    tags: json["tags"],
    seoTitle: json["seo_title"],
    metaDescription: json["meta_description"],
    status: json["status"],
    publishDate: json["publish_date"],
    visibility: json["visibility"],
    specificCustomerGroups: json["specific_customer_groups"],
    lastUpdatedBy: json["last_updated_by"],
    // technicalSpecifications: json["technical_specifications"] == null ? null : TechnicalSpecifications.fromJson(json["technical_specifications"]),
    hasVariant: json["has_variant"],
    woodenBoxPackaging: json["wooden_box_packaging"],
    isPerfume: json["is_perfume"],
    containsBattery: json["contains_battery"],
    isCosmetics: json["is_cosmetics"],
    containsMagnet: json["contains_magnet"],
    countryOfOrigin: json["country_of_origin"],
    hsCode: json["hs_code"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    lastUpdatedAt: json["last_updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller": seller?.toJson(),
    "category": category?.toJson(),
    "brand": brand,
    "reviews":
        reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "variations":
        variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
    "name": name,
    "sku": sku,
    "model_number": modelNumber,
    "product_type": productType,
    "badge": badge,
    "short_description": shortDescription,
    "long_description": longDescription,
    "key_features": keyFeatures,
    "main_image": mainImage,
    "gallery":
        gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "video_url": videoUrl,
    "regular_price": regularPrice,
    "local_transit_fee": localTransitFee,
    "sale_price": salePrice,
    "currency": currency,
    "available_stock": availableStock,
    "low_stock_alert": lowStockAlert,
    "purchase_limit": purchaseLimit,
    "commission_percentage": commissionPercentage,
    "weight": weight,
    "weight_unit": weightUnit,
    "shipping_weight": shippingWeight,
    "shipping_weight_unit": shippingWeightUnit,
    "dimensions": dimensions?.toJson(),
    "packaging_dimensions": packagingDimensions?.toJson(),
    "packaging_details":
        packagingDetails == null
            ? []
            : List<dynamic>.from(packagingDetails!.map((x) => x.toJson())),
    "shipping_methods": shippingMethods,
    "shipping_region": shippingRegion,
    "shipping_countries":
        shippingCountries == null
            ? []
            : List<dynamic>.from(shippingCountries!.map((x) => x)),
    "handling_time": handlingTime,
    "returns_policy": returnsPolicy,
    "tags": tags,
    "seo_title": seoTitle,
    "meta_description": metaDescription,
    "status": status,
    "publish_date": publishDate,
    "visibility": visibility,
    "specific_customer_groups": specificCustomerGroups,
    "last_updated_by": lastUpdatedBy,
    // "technical_specifications": technicalSpecifications?.toJson(),
    "has_variant": hasVariant,
    "wooden_box_packaging": woodenBoxPackaging,
    "is_perfume": isPerfume,
    "contains_battery": containsBattery,
    "is_cosmetics": isCosmetics,
    "contains_magnet": containsMagnet,
    "country_of_origin": countryOfOrigin,
    "hs_code": hsCode,
    "is_active": isActive,
    "created_at": createdAt,
    "last_updated_at": lastUpdatedAt,
  };
}

class Category {
  int? id;
  String? name;
  int? parent;

  // List<dynamic>? subcategories;
  // dynamic allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    // this.subcategories,
    // this.allowedAttributes,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    // subcategories: json["subcategories"] == null ? [] : List<dynamic>.from(json["subcategories"]!.map((x) => x)),
    // allowedAttributes: json["allowed_attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    // "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x)),
    // "allowed_attributes": allowedAttributes,
  };
}

class Dimensions {
  Height? width;
  Height? height;
  Height? length;
  Height? weight;

  Dimensions({this.width, this.height, this.length, this.weight});

  factory Dimensions.fromRawJson(String str) =>
      Dimensions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: json["width"] == null ? null : Height.fromJson(json["width"]),
    height: json["height"] == null ? null : Height.fromJson(json["height"]),
    length: json["length"] == null ? null : Height.fromJson(json["length"]),
    weight: json["weight"] == null ? null : Height.fromJson(json["weight"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
    "weight": weight?.toJson(),
  };
}

class Height {
  String? unit;
  String? value;

  Height({this.unit, this.value});

  factory Height.fromRawJson(String str) => Height.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Height.fromJson(Map<String, dynamic> json) =>
      Height(unit: json["unit"], value: json["value"]);

  Map<String, dynamic> toJson() => {"unit": unit, "value": value};
}

class Seller {
  int? id;
  String? businessName;

  Seller({this.id, this.businessName});

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) =>
      Seller(id: json["id"], businessName: json["business_name"]);

  Map<String, dynamic> toJson() => {"id": id, "business_name": businessName};
}

class TechnicalSpecifications {
  TechnicalSpecifications();

  factory TechnicalSpecifications.fromRawJson(String str) =>
      TechnicalSpecifications.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TechnicalSpecifications.fromJson(Map<String, dynamic> json) =>
      TechnicalSpecifications();

  Map<String, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
