import 'dart:convert';

class CartModel {
  String? status;
  String? message;
  Data? data;

  CartModel({this.status, this.message, this.data});

  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  dynamic customer;
  String? sessionKey;
  String? createdAt;
  List<Item>? items;

  Data({this.id, this.customer, this.sessionKey, this.createdAt, this.items});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    customer: json["customer"],
    sessionKey: json["session_key"],
    createdAt: json["created_at"],
    items:
        json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "session_key": sessionKey,
    "created_at": createdAt,
    "items":
        items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? id;
  int? cart;
  Product? product;
  Variant? variant;
  int? quantity;
  dynamic voucherCode;
  String? discountAmount;
  String? addedAt;
  bool? isChecked;

  Item({
    this.id,
    this.cart,
    this.product,
    this.variant,
    this.quantity,
    this.voucherCode,
    this.discountAmount,
    this.addedAt,
    this.isChecked,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    cart: json["cart"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
    quantity: json["quantity"],
    voucherCode: json["voucher_code"],
    discountAmount: json["discount_amount"],
    addedAt: json["added_at"],
    isChecked: json["is_checked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart": cart,
    "product": product?.toJson(),
    "variant": variant?.toJson(),
    "quantity": quantity,
    "voucher_code": voucherCode,
    "discount_amount": discountAmount,
    "added_at": addedAt,
    "is_checked": isChecked,
  };
}

class Product {
  String? id;
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
  TechnicalSpecifications? technicalSpecifications;
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
  int? seller;
  Category? category;
  int? brand;

  Product({
    this.id,
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
    this.seller,
    this.category,
    this.brand,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
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
    technicalSpecifications:
        json["technical_specifications"] == null
            ? null
            : TechnicalSpecifications.fromJson(
              json["technical_specifications"],
            ),
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
    seller: json["seller"],
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "seller": seller,
    "category": category?.toJson(),
    "brand": brand,
  };
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<dynamic>? subcategories;
  dynamic allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories:
        json["subcategories"] == null
            ? []
            : List<dynamic>.from(json["subcategories"]!.map((x) => x)),
    allowedAttributes: json["allowed_attributes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories":
        subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x)),
    "allowed_attributes": allowedAttributes,
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
      Height(unit: json["unit"], value: json["value"].toString());

  Map<String, dynamic> toJson() => {"unit": unit, "value": value};
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

class Variant {
  String? size;
  String? color;
  String? material;
  String? style;
  dynamic count;
  String? capacity;
  String? powerConsumption;
  String? voltage;
  String? packSize;
  dynamic expirationDate;
  String? energyRating;
  String? warrantyPeriod;
  String? pattern;
  String? occasion;
  String? name;
  String? sku;
  String? modelNumber;
  String? mainImage;
  dynamic gallery;
  String? videoUrl;
  dynamic regularPrice;
  dynamic salePrice;
  String? currency;
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
  String? handlingTime;
  String? tags;
  String? seoTitle;
  String? metaDescription;
  dynamic status;
  dynamic publishDate;
  dynamic visibility;
  dynamic specificCustomerGroups;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  String? countryOfOrigin;
  String? hsCode;
  String? lastUpdatedBy;
  dynamic technicalSpecifications;
  bool? isActive;
  dynamic product;

  Variant({
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
    this.product,
  });

  factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
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
    gallery: json["gallery"],
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
    dimensions: json["dimensions"],
    packagingDimensions: json["packaging_dimensions"],
    packagingDetails: json["packaging_details"],
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
    technicalSpecifications: json["technical_specifications"],
    isActive: json["is_active"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
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
    "gallery": gallery,
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
    "dimensions": dimensions,
    "packaging_dimensions": packagingDimensions,
    "packaging_details": packagingDetails,
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
    "technical_specifications": technicalSpecifications,
    "is_active": isActive,
    "product": product,
  };
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
