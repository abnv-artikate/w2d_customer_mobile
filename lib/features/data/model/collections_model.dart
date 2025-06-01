import 'dart:convert';

class CollectionsModel {
  int? count;
  dynamic next;
  dynamic previous;
  CollectionsResultsModel? results;

  CollectionsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CollectionsModel.fromRawJson(String str) => CollectionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollectionsModel.fromJson(Map<String, dynamic> json) => CollectionsModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? null : CollectionsResultsModel.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results?.toJson(),
  };
}

class CollectionsResultsModel {
  String? status;
  String? message;
  List<CollectionsResultDataModel>? data;

  CollectionsResultsModel({
    this.status,
    this.message,
    this.data,
  });

  factory CollectionsResultsModel.fromRawJson(String str) => CollectionsResultsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollectionsResultsModel.fromJson(Map<String, dynamic> json) => CollectionsResultsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CollectionsResultDataModel>.from(json["data"]!.map((x) => CollectionsResultDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CollectionsResultDataModel {
  String? id;
  List<CollectionsResultDataProductModel>? products;
  String? name;
  String? slug;
  String? collectionType;
  String? description;
  String? backgroundImage;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  CollectionsResultDataModel({
    this.id,
    this.products,
    this.name,
    this.slug,
    this.collectionType,
    this.description,
    this.backgroundImage,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CollectionsResultDataModel.fromRawJson(String str) => CollectionsResultDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollectionsResultDataModel.fromJson(Map<String, dynamic> json) => CollectionsResultDataModel(
    id: json["id"],
    products: json["products"] == null ? [] : List<CollectionsResultDataProductModel>.from(json["products"]!.map((x) => CollectionsResultDataProductModel.fromJson(x))),
    name: json["name"],
    slug: json["slug"],
    collectionType: json["collection_type"],
    description: json["description"],
    backgroundImage: json["background_image"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "name": name,
    "slug": slug,
    "collection_type": collectionType,
    "description": description,
    "background_image": backgroundImage,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class CollectionsResultDataProductModel {
  String? id;
  Seller? seller;
  Category? category;
  Brand? brand;
  List<dynamic>? reviews;
  List<Variation>? variations;
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
  String? commissionPercentage;
  String? weight;
  String? weightUnit;
  dynamic shippingWeight;
  String? shippingWeightUnit;
  ProductDimensions? dimensions;
  PackagingDimensions? packagingDimensions;
  List<PackagingDetail>? packagingDetails;
  String? shippingMethods;
  String? shippingRegion;
  List<String>? shippingCountries;
  String? handlingTime;
  String? returnsPolicy;
  String? tags;
  dynamic seoTitle;
  String? metaDescription;
  String? status;
  dynamic publishDate;
  String? visibility;
  dynamic specificCustomerGroups;
  dynamic lastUpdatedBy;
  ProductTechnicalSpecifications? technicalSpecifications;
  bool? hasVariant;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  String? countryOfOrigin;
  String? hsCode;
  bool? isActive;
  String? createdAt;
  String? lastUpdatedAt;

  CollectionsResultDataProductModel({
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
    this.technicalSpecifications,
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

  factory CollectionsResultDataProductModel.fromRawJson(String str) => CollectionsResultDataProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollectionsResultDataProductModel.fromJson(Map<String, dynamic> json) => CollectionsResultDataProductModel(
    id: json["id"],
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
    name: json["name"],
    sku: json["sku"],
    modelNumber: json["model_number"],
    productType: json["product_type"],
    badge: json["badge"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    keyFeatures: json["key_features"],
    mainImage: json["main_image"],
    gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
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
    dimensions: json["dimensions"] == null ? null : ProductDimensions.fromJson(json["dimensions"]),
    packagingDimensions: json["packaging_dimensions"] == null ? null : PackagingDimensions.fromJson(json["packaging_dimensions"]),
    packagingDetails: json["packaging_details"] == null ? [] : List<PackagingDetail>.from(json["packaging_details"]!.map((x) => PackagingDetail.fromJson(x))),
    shippingMethods: json["shipping_methods"],
    shippingRegion: json["shipping_region"],
    shippingCountries: json["shipping_countries"] == null ? [] : List<String>.from(json["shipping_countries"]!.map((x) => x)),
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
    technicalSpecifications: json["technical_specifications"] == null ? null : ProductTechnicalSpecifications.fromJson(json["technical_specifications"]),
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
    "brand": brand?.toJson(),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
    "name": name,
    "sku": sku,
    "model_number": modelNumber,
    "product_type": productType,
    "badge": badge,
    "short_description": shortDescription,
    "long_description": longDescription,
    "key_features": keyFeatures,
    "main_image": mainImage,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
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
    "packaging_details": packagingDetails == null ? [] : List<dynamic>.from(packagingDetails!.map((x) => x.toJson())),
    "shipping_methods": shippingMethods,
    "shipping_region": shippingRegion,
    "shipping_countries": shippingCountries == null ? [] : List<dynamic>.from(shippingCountries!.map((x) => x)),
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
    "technical_specifications": technicalSpecifications?.toJson(),
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

class Brand {
  int? id;
  String? name;
  dynamic description;

  Brand({
    this.id,
    this.name,
    this.description,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

class Subcategory {
  int? id;
  String? name;
  int? parent;
  List<Category>? subcategories;
  Map<String, List<String>>? allowedAttributes;

  Subcategory({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory Subcategory.fromRawJson(String str) => Subcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories: json["subcategories"] == null ? [] : List<Category>.from(json["subcategories"]!.map((x) => Category.fromJson(x))),
    allowedAttributes: Map.from(json["allowed_attributes"]!).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "allowed_attributes": Map.from(allowedAttributes!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
  };
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<Subcategory>? subcategories;
  AllowedAttributes? allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
    allowedAttributes: json["allowed_attributes"] == null ? null : AllowedAttributes.fromJson(json["allowed_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "allowed_attributes": allowedAttributes?.toJson(),
  };
}

class AllowedAttributes {
  List<String>? size;
  List<String>? color;
  List<String>? wattage;
  List<String>? material;
  List<String>? switchType;
  List<String>? lightSourceType;
  List<String>? topNotes;
  List<String>? baseNotes;
  List<String>? heartNotes;
  List<String>? lensType;
  List<String>? frameShape;
  List<String>? lensMaterial;
  List<String>? uvProtection;
  List<String>? brand;
  Notes? notes;
  List<String>? season;
  List<String>? sillage;
  List<String>? occasion;
  List<String>? longevity;
  List<String>? bottleDesign;
  List<String>? concentration;
  List<String>? fragranceFamily;
  List<String>? chairDimensions;
  List<String>? seatingCapacity;
  List<String>? tableDimensions;
  List<String>? weightCapacity;
  List<String>? cushionIncluded;
  List<String>? firmness;
  List<String>? dimensions;
  List<String>? mattressType;

  AllowedAttributes({
    this.size,
    this.color,
    this.wattage,
    this.material,
    this.switchType,
    this.lightSourceType,
    this.topNotes,
    this.baseNotes,
    this.heartNotes,
    this.lensType,
    this.frameShape,
    this.lensMaterial,
    this.uvProtection,
    this.brand,
    this.notes,
    this.season,
    this.sillage,
    this.occasion,
    this.longevity,
    this.bottleDesign,
    this.concentration,
    this.fragranceFamily,
    this.chairDimensions,
    this.seatingCapacity,
    this.tableDimensions,
    this.weightCapacity,
    this.cushionIncluded,
    this.firmness,
    this.dimensions,
    this.mattressType,
  });

  factory AllowedAttributes.fromRawJson(String str) => AllowedAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllowedAttributes.fromJson(Map<String, dynamic> json) => AllowedAttributes(
    size: json["size"] == null ? [] : List<String>.from(json["size"]!.map((x) => x)),
    color: json["color"] == null ? [] : List<String>.from(json["color"]!.map((x) => x)),
    wattage: json["Wattage"] == null ? [] : List<String>.from(json["Wattage"]!.map((x) => x)),
    material: json["Material"] == null ? [] : List<String>.from(json["Material"]!.map((x) => x)),
    switchType: json["Switch Type"] == null ? [] : List<String>.from(json["Switch Type"]!.map((x) => x)),
    lightSourceType: json["Light Source Type"] == null ? [] : List<String>.from(json["Light Source Type"]!.map((x) => x)),
    topNotes: json["Top Notes"] == null ? [] : List<String>.from(json["Top Notes"]!.map((x) => x)),
    baseNotes: json["Base Notes"] == null ? [] : List<String>.from(json["Base Notes"]!.map((x) => x)),
    heartNotes: json["Heart Notes"] == null ? [] : List<String>.from(json["Heart Notes"]!.map((x) => x)),
    lensType: json["Lens Type"] == null ? [] : List<String>.from(json["Lens Type"]!.map((x) => x)),
    frameShape: json["Frame Shape"] == null ? [] : List<String>.from(json["Frame Shape"]!.map((x) => x)),
    lensMaterial: json["Lens Material"] == null ? [] : List<String>.from(json["Lens Material"]!.map((x) => x)),
    uvProtection: json["UV Protection"] == null ? [] : List<String>.from(json["UV Protection"]!.map((x) => x)),
    brand: json["brand"] == null ? [] : List<String>.from(json["brand"]!.map((x) => x)),
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    season: json["season"] == null ? [] : List<String>.from(json["season"]!.map((x) => x)),
    sillage: json["sillage"] == null ? [] : List<String>.from(json["sillage"]!.map((x) => x)),
    occasion: json["occasion"] == null ? [] : List<String>.from(json["occasion"]!.map((x) => x)),
    longevity: json["longevity"] == null ? [] : List<String>.from(json["longevity"]!.map((x) => x)),
    bottleDesign: json["bottle design"] == null ? [] : List<String>.from(json["bottle design"]!.map((x) => x)),
    concentration: json["concentration"] == null ? [] : List<String>.from(json["concentration"]!.map((x) => x)),
    fragranceFamily: json["fragrance family"] == null ? [] : List<String>.from(json["fragrance family"]!.map((x) => x)),
    chairDimensions: json["Chair Dimensions"] == null ? [] : List<String>.from(json["Chair Dimensions"]!.map((x) => x)),
    seatingCapacity: json["Seating Capacity"] == null ? [] : List<String>.from(json["Seating Capacity"]!.map((x) => x)),
    tableDimensions: json["Table Dimensions"] == null ? [] : List<String>.from(json["Table Dimensions"]!.map((x) => x)),
    weightCapacity: json["Weight Capacity"] == null ? [] : List<String>.from(json["Weight Capacity"]!.map((x) => x)),
    cushionIncluded: json["Cushion Included"] == null ? [] : List<String>.from(json["Cushion Included"]!.map((x) => x)),
    firmness: json["Firmness"] == null ? [] : List<String>.from(json["Firmness"]!.map((x) => x)),
    dimensions: json["Dimensions"] == null ? [] : List<String>.from(json["Dimensions"]!.map((x) => x)),
    mattressType: json["Mattress Type"] == null ? [] : List<String>.from(json["Mattress Type"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
    "color": color == null ? [] : List<dynamic>.from(color!.map((x) => x)),
    "Wattage": wattage == null ? [] : List<dynamic>.from(wattage!.map((x) => x)),
    "Material": material == null ? [] : List<dynamic>.from(material!.map((x) => x)),
    "Switch Type": switchType == null ? [] : List<dynamic>.from(switchType!.map((x) => x)),
    "Light Source Type": lightSourceType == null ? [] : List<dynamic>.from(lightSourceType!.map((x) => x)),
    "Top Notes": topNotes == null ? [] : List<dynamic>.from(topNotes!.map((x) => x)),
    "Base Notes": baseNotes == null ? [] : List<dynamic>.from(baseNotes!.map((x) => x)),
    "Heart Notes": heartNotes == null ? [] : List<dynamic>.from(heartNotes!.map((x) => x)),
    "Lens Type": lensType == null ? [] : List<dynamic>.from(lensType!.map((x) => x)),
    "Frame Shape": frameShape == null ? [] : List<dynamic>.from(frameShape!.map((x) => x)),
    "Lens Material": lensMaterial == null ? [] : List<dynamic>.from(lensMaterial!.map((x) => x)),
    "UV Protection": uvProtection == null ? [] : List<dynamic>.from(uvProtection!.map((x) => x)),
    "brand": brand == null ? [] : List<dynamic>.from(brand!.map((x) => x)),
    "notes": notes?.toJson(),
    "season": season == null ? [] : List<dynamic>.from(season!.map((x) => x)),
    "sillage": sillage == null ? [] : List<dynamic>.from(sillage!.map((x) => x)),
    "occasion": occasion == null ? [] : List<dynamic>.from(occasion!.map((x) => x)),
    "longevity": longevity == null ? [] : List<dynamic>.from(longevity!.map((x) => x)),
    "bottle design": bottleDesign == null ? [] : List<dynamic>.from(bottleDesign!.map((x) => x)),
    "concentration": concentration == null ? [] : List<dynamic>.from(concentration!.map((x) => x)),
    "fragrance family": fragranceFamily == null ? [] : List<dynamic>.from(fragranceFamily!.map((x) => x)),
    "Chair Dimensions": chairDimensions == null ? [] : List<dynamic>.from(chairDimensions!.map((x) => x)),
    "Seating Capacity": seatingCapacity == null ? [] : List<dynamic>.from(seatingCapacity!.map((x) => x)),
    "Table Dimensions": tableDimensions == null ? [] : List<dynamic>.from(tableDimensions!.map((x) => x)),
    "Weight Capacity": weightCapacity == null ? [] : List<dynamic>.from(weightCapacity!.map((x) => x)),
    "Cushion Included": cushionIncluded == null ? [] : List<dynamic>.from(cushionIncluded!.map((x) => x)),
    "Firmness": firmness == null ? [] : List<dynamic>.from(firmness!.map((x) => x)),
    "Dimensions": dimensions == null ? [] : List<dynamic>.from(dimensions!.map((x) => x)),
    "Mattress Type": mattressType == null ? [] : List<dynamic>.from(mattressType!.map((x) => x)),
  };
}

class Notes {
  List<String>? topNotes;
  List<String>? baseNotes;
  List<String>? middleNotes;

  Notes({
    this.topNotes,
    this.baseNotes,
    this.middleNotes,
  });

  factory Notes.fromRawJson(String str) => Notes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    topNotes: json["top notes"] == null ? [] : List<String>.from(json["top notes"]!.map((x) => x)),
    baseNotes: json["base notes"] == null ? [] : List<String>.from(json["base notes"]!.map((x) => x)),
    middleNotes: json["middle notes"] == null ? [] : List<String>.from(json["middle notes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "top notes": topNotes == null ? [] : List<dynamic>.from(topNotes!.map((x) => x)),
    "base notes": baseNotes == null ? [] : List<dynamic>.from(baseNotes!.map((x) => x)),
    "middle notes": middleNotes == null ? [] : List<dynamic>.from(middleNotes!.map((x) => x)),
  };
}

class ProductDimensions {
  PurpleHeight? width;
  PurpleHeight? height;
  PurpleHeight? length;

  ProductDimensions({
    this.width,
    this.height,
    this.length,
  });

  factory ProductDimensions.fromRawJson(String str) => ProductDimensions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDimensions.fromJson(Map<String, dynamic> json) => ProductDimensions(
    width: json["width"] == null ? null : PurpleHeight.fromJson(json["width"]),
    height: json["height"] == null ? null : PurpleHeight.fromJson(json["height"]),
    length: json["length"] == null ? null : PurpleHeight.fromJson(json["length"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
  };
}

class PurpleHeight {
  String? unit;
  dynamic value;

  PurpleHeight({
    this.unit,
    this.value,
  });

  factory PurpleHeight.fromRawJson(String str) => PurpleHeight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurpleHeight.fromJson(Map<String, dynamic> json) => PurpleHeight(
    unit: json["unit"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "unit": unit,
    "value": value,
  };
}

class PackagingDetail {
  PurpleHeight? width;
  PurpleHeight? height;
  PurpleHeight? length;
  PurpleHeight? weight;
  String? woodenBoxPackaging;

  PackagingDetail({
    this.width,
    this.height,
    this.length,
    this.weight,
    this.woodenBoxPackaging,
  });

  factory PackagingDetail.fromRawJson(String str) => PackagingDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackagingDetail.fromJson(Map<String, dynamic> json) => PackagingDetail(
    width: json["width"] == null ? null : PurpleHeight.fromJson(json["width"]),
    height: json["height"] == null ? null : PurpleHeight.fromJson(json["height"]),
    length: json["length"] == null ? null : PurpleHeight.fromJson(json["length"]),
    weight: json["weight"] == null ? null : PurpleHeight.fromJson(json["weight"]),
    woodenBoxPackaging: json["wooden_box_packaging"],
  );

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
    "weight": weight?.toJson(),
    "wooden_box_packaging": woodenBoxPackaging,
  };
}

class PackagingDimensions {
  PackagingDimensionsHeight? width;
  PackagingDimensionsHeight? height;
  PackagingDimensionsHeight? length;

  PackagingDimensions({
    this.width,
    this.height,
    this.length,
  });

  factory PackagingDimensions.fromRawJson(String str) => PackagingDimensions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackagingDimensions.fromJson(Map<String, dynamic> json) => PackagingDimensions(
    width: json["width"] == null ? null : PackagingDimensionsHeight.fromJson(json["width"]),
    height: json["height"] == null ? null : PackagingDimensionsHeight.fromJson(json["height"]),
    length: json["length"] == null ? null : PackagingDimensionsHeight.fromJson(json["length"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
  };
}

class PackagingDimensionsHeight {
  String? unit;
  String? value;

  PackagingDimensionsHeight({
    this.unit,
    this.value,
  });

  factory PackagingDimensionsHeight.fromRawJson(String str) => PackagingDimensionsHeight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackagingDimensionsHeight.fromJson(Map<String, dynamic> json) => PackagingDimensionsHeight(
    unit: json["unit"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "unit": unit,
    "value": value,
  };
}

class Seller {
  int? id;
  String? businessName;

  Seller({
    this.id,
    this.businessName,
  });

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    businessName: json["business_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
  };
}

class ProductTechnicalSpecifications {
  String? topNotes;
  String? heartNotes;
  String? lensType;
  String? frameShape;
  String? lensMaterial;
  String? uvProtection;
  String? material;
  String? chairDimensions;
  String? seatingCapacity;
  String? tableDimensions;

  ProductTechnicalSpecifications({
    this.topNotes,
    this.heartNotes,
    this.lensType,
    this.frameShape,
    this.lensMaterial,
    this.uvProtection,
    this.material,
    this.chairDimensions,
    this.seatingCapacity,
    this.tableDimensions,
  });

  factory ProductTechnicalSpecifications.fromRawJson(String str) => ProductTechnicalSpecifications.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductTechnicalSpecifications.fromJson(Map<String, dynamic> json) => ProductTechnicalSpecifications(
    topNotes: json["Top Notes"],
    heartNotes: json["Heart Notes"],
    lensType: json["Lens Type"],
    frameShape: json["Frame Shape"],
    lensMaterial: json["Lens Material"],
    uvProtection: json["UV Protection"],
    material: json["Material"],
    chairDimensions: json["Chair Dimensions"],
    seatingCapacity: json["Seating Capacity"],
    tableDimensions: json["Table Dimensions"],
  );

  Map<String, dynamic> toJson() => {
    "Top Notes": topNotes,
    "Heart Notes": heartNotes,
    "Lens Type": lensType,
    "Frame Shape": frameShape,
    "Lens Material": lensMaterial,
    "UV Protection": uvProtection,
    "Material": material,
    "Chair Dimensions": chairDimensions,
    "Seating Capacity": seatingCapacity,
    "Table Dimensions": tableDimensions,
  };
}

class Variation {
  String? id;
  String? size;
  String? color;
  dynamic material;
  dynamic style;
  dynamic count;
  dynamic capacity;
  dynamic powerConsumption;
  dynamic voltage;
  dynamic packSize;
  dynamic expirationDate;
  dynamic energyRating;
  dynamic warrantyPeriod;
  dynamic pattern;
  dynamic occasion;
  String? name;
  String? sku;
  dynamic modelNumber;
  String? mainImage;
  List<dynamic>? gallery;
  dynamic videoUrl;
  String? regularPrice;
  String? salePrice;
  dynamic currency;
  int? availableStock;
  int? lowStockAlert;
  dynamic purchaseLimit;
  String? weight;
  String? weightUnit;
  dynamic shippingWeight;
  String? shippingWeightUnit;
  PackagingDetailClass? dimensions;
  dynamic packagingDimensions;
  List<PackagingDetailClass>? packagingDetails;
  String? shippingMethods;
  String? shippingRegion;
  dynamic shippingCountries;
  String? handlingTime;
  dynamic tags;
  dynamic seoTitle;
  dynamic metaDescription;
  String? status;
  dynamic publishDate;
  String? visibility;
  dynamic specificCustomerGroups;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  dynamic countryOfOrigin;
  dynamic hsCode;
  dynamic lastUpdatedBy;
  VariationTechnicalSpecifications? technicalSpecifications;
  bool? isActive;
  String? createdAt;
  String? lastUpdatedAt;
  String? product;

  Variation({
    this.id,
    this.size,
    this.color,
    this.material,
    this.style,
    this.count,
    this.capacity,
    this.powerConsumption,
    this.voltage,
    this.packSize,
    this.expirationDate,
    this.energyRating,
    this.warrantyPeriod,
    this.pattern,
    this.occasion,
    this.name,
    this.sku,
    this.modelNumber,
    this.mainImage,
    this.gallery,
    this.videoUrl,
    this.regularPrice,
    this.salePrice,
    this.currency,
    this.availableStock,
    this.lowStockAlert,
    this.purchaseLimit,
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
    this.tags,
    this.seoTitle,
    this.metaDescription,
    this.status,
    this.publishDate,
    this.visibility,
    this.specificCustomerGroups,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.countryOfOrigin,
    this.hsCode,
    this.lastUpdatedBy,
    this.technicalSpecifications,
    this.isActive,
    this.createdAt,
    this.lastUpdatedAt,
    this.product,
  });

  factory Variation.fromRawJson(String str) => Variation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    size: json["size"],
    color: json["color"],
    material: json["material"],
    style: json["style"],
    count: json["count"],
    capacity: json["capacity"],
    powerConsumption: json["power_consumption"],
    voltage: json["voltage"],
    packSize: json["pack_size"],
    expirationDate: json["expiration_date"],
    energyRating: json["energy_rating"],
    warrantyPeriod: json["warranty_period"],
    pattern: json["pattern"],
    occasion: json["occasion"],
    name: json["name"],
    sku: json["sku"],
    modelNumber: json["model_number"],
    mainImage: json["main_image"],
    gallery: json["gallery"] == null ? [] : List<dynamic>.from(json["gallery"]!.map((x) => x)),
    videoUrl: json["video_url"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    currency: json["currency"],
    availableStock: json["available_stock"],
    lowStockAlert: json["low_stock_alert"],
    purchaseLimit: json["purchase_limit"],
    weight: json["weight"],
    weightUnit: json["weight_unit"],
    shippingWeight: json["shipping_weight"],
    shippingWeightUnit: json["shipping_weight_unit"],
    dimensions: json["dimensions"] == null ? null : PackagingDetailClass.fromJson(json["dimensions"]),
    packagingDimensions: json["packaging_dimensions"],
    packagingDetails: json["packaging_details"] == null ? [] : List<PackagingDetailClass>.from(json["packaging_details"]!.map((x) => PackagingDetailClass.fromJson(x))),
    shippingMethods: json["shipping_methods"],
    shippingRegion: json["shipping_region"],
    shippingCountries: json["shipping_countries"],
    handlingTime: json["handling_time"],
    tags: json["tags"],
    seoTitle: json["seo_title"],
    metaDescription: json["meta_description"],
    status: json["status"],
    publishDate: json["publish_date"],
    visibility: json["visibility"],
    specificCustomerGroups: json["specific_customer_groups"],
    woodenBoxPackaging: json["wooden_box_packaging"],
    isPerfume: json["is_perfume"],
    containsBattery: json["contains_battery"],
    isCosmetics: json["is_cosmetics"],
    containsMagnet: json["contains_magnet"],
    countryOfOrigin: json["country_of_origin"],
    hsCode: json["hs_code"],
    lastUpdatedBy: json["last_updated_by"],
    technicalSpecifications: json["technical_specifications"] == null ? null : VariationTechnicalSpecifications.fromJson(json["technical_specifications"]),
    isActive: json["is_active"],
    createdAt: json["created_at"],
    lastUpdatedAt: json["last_updated_at"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size": size,
    "color": color,
    "material": material,
    "style": style,
    "count": count,
    "capacity": capacity,
    "power_consumption": powerConsumption,
    "voltage": voltage,
    "pack_size": packSize,
    "expiration_date": expirationDate,
    "energy_rating": energyRating,
    "warranty_period": warrantyPeriod,
    "pattern": pattern,
    "occasion": occasion,
    "name": name,
    "sku": sku,
    "model_number": modelNumber,
    "main_image": mainImage,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "video_url": videoUrl,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "currency": currency,
    "available_stock": availableStock,
    "low_stock_alert": lowStockAlert,
    "purchase_limit": purchaseLimit,
    "weight": weight,
    "weight_unit": weightUnit,
    "shipping_weight": shippingWeight,
    "shipping_weight_unit": shippingWeightUnit,
    "dimensions": dimensions?.toJson(),
    "packaging_dimensions": packagingDimensions,
    "packaging_details": packagingDetails == null ? [] : List<dynamic>.from(packagingDetails!.map((x) => x.toJson())),
    "shipping_methods": shippingMethods,
    "shipping_region": shippingRegion,
    "shipping_countries": shippingCountries,
    "handling_time": handlingTime,
    "tags": tags,
    "seo_title": seoTitle,
    "meta_description": metaDescription,
    "status": status,
    "publish_date": publishDate,
    "visibility": visibility,
    "specific_customer_groups": specificCustomerGroups,
    "wooden_box_packaging": woodenBoxPackaging,
    "is_perfume": isPerfume,
    "contains_battery": containsBattery,
    "is_cosmetics": isCosmetics,
    "contains_magnet": containsMagnet,
    "country_of_origin": countryOfOrigin,
    "hs_code": hsCode,
    "last_updated_by": lastUpdatedBy,
    "technical_specifications": technicalSpecifications?.toJson(),
    "is_active": isActive,
    "created_at": createdAt,
    "last_updated_at": lastUpdatedAt,
    "product": product,
  };
}

class PackagingDetailClass {
  FluffyHeight? width;
  FluffyHeight? height;
  FluffyHeight? length;
  FluffyHeight? weight;

  PackagingDetailClass({
    this.width,
    this.height,
    this.length,
    this.weight,
  });

  factory PackagingDetailClass.fromRawJson(String str) => PackagingDetailClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackagingDetailClass.fromJson(Map<String, dynamic> json) => PackagingDetailClass(
    width: json["width"] == null ? null : FluffyHeight.fromJson(json["width"]),
    height: json["height"] == null ? null : FluffyHeight.fromJson(json["height"]),
    length: json["length"] == null ? null : FluffyHeight.fromJson(json["length"]),
    weight: json["weight"] == null ? null : FluffyHeight.fromJson(json["weight"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
    "weight": weight?.toJson(),
  };
}

class FluffyHeight {
  String? unit;
  int? value;

  FluffyHeight({
    this.unit,
    this.value,
  });

  factory FluffyHeight.fromRawJson(String str) => FluffyHeight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FluffyHeight.fromJson(Map<String, dynamic> json) => FluffyHeight(
    unit: json["unit"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "unit": unit,
    "value": value,
  };
}

class VariationTechnicalSpecifications {
  VariationTechnicalSpecifications();

  factory VariationTechnicalSpecifications.fromRawJson(String str) => VariationTechnicalSpecifications.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VariationTechnicalSpecifications.fromJson(Map<String, dynamic> json) => VariationTechnicalSpecifications(
  );

  Map<String, dynamic> toJson() => {
  };
}
