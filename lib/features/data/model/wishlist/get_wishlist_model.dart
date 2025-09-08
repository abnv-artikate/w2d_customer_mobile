import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/wishlist/wishlist_entity.dart';

class GetWishListModel {
  String? status;
  Data? data;

  GetWishListModel({this.status, this.data});

  factory GetWishListModel.fromRawJson(String str) =>
      GetWishListModel.fromJson(json.decode(str));

  factory GetWishListModel.fromJson(Map<String, dynamic> json) =>
      GetWishListModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  WishListEntity toEntity() {
    return WishListEntity(status: status ?? "", data: data!.toEntity());
  }
}

class Data {
  int? id;
  int? customer;
  String? createdAt;
  List<Item>? items;

  Data({this.id, this.customer, this.createdAt, this.items});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    customer: json["customer"],
    createdAt: json["created_at"],
    items:
        json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  WishListDataEntity toEntity() {
    return WishListDataEntity(
      id: id ?? -1,
      customer: customer ?? -1,
      createdAt: createdAt ?? "",
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class Item {
  int? id;
  int? wishlist;
  Product? product;
  dynamic variant;
  String? addedAt;

  Item({this.id, this.wishlist, this.product, this.variant, this.addedAt});

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    wishlist: json["wishlist"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    variant: json["variant"],
    addedAt: json["added_at"],
  );

  WishListDataItemEntity toEntity() {
    return WishListDataItemEntity(
      id: id ?? -1,
      wishlist: wishlist ?? -1,
      product: product!.toEntity(),
      variant: variant,
      addedAt: addedAt ?? "",
    );
  }
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
  dynamic purchaseLimit;
  String? commissionPercentage;
  String? weight;
  String? weightUnit;
  dynamic shippingWeight;
  String? shippingWeightUnit;
  Dimensions? dimensions;
  dynamic packagingDimensions;
  List<PackagingDetail>? packagingDetails;
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
  bool? hasVariant;
  bool? woodenBoxPackaging;
  bool? isPerfume;
  bool? containsBattery;
  bool? isCosmetics;
  bool? containsMagnet;
  bool? selfFulfilled;
  String? countryOfOrigin;
  String? hsCode;
  bool? isMarketplace;
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
    this.hasVariant,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.selfFulfilled,
    this.countryOfOrigin,
    this.hsCode,
    this.isMarketplace,
    this.isActive,
    this.createdAt,
    this.lastUpdatedAt,
    this.seller,
    this.category,
    this.brand,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

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
    packagingDimensions: json["packaging_dimensions"],
    packagingDetails:
        json["packaging_details"] == null
            ? []
            : List<PackagingDetail>.from(
              json["packaging_details"]!.map(
                (x) => PackagingDetail.fromJson(x),
              ),
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
    hasVariant: json["has_variant"],
    woodenBoxPackaging: json["wooden_box_packaging"],
    isPerfume: json["is_perfume"],
    containsBattery: json["contains_battery"],
    isCosmetics: json["is_cosmetics"],
    containsMagnet: json["contains_magnet"],
    selfFulfilled: json["self_fulfilled"],
    countryOfOrigin: json["country_of_origin"],
    hsCode: json["hs_code"],
    isMarketplace: json["is_marketplace"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    lastUpdatedAt: json["last_updated_at"],
    seller: json["seller"],
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"],
  );

  WishListDataItemProductEntity toEntity() {
    return WishListDataItemProductEntity(
      id: id ?? "",
      name: name ?? "",
      sku: sku ?? "",
      modelNumber: modelNumber,
      productType: productType ?? "",
      badge: badge ?? "",
      shortDescription: shortDescription ?? "",
      longDescription: longDescription ?? "",
      keyFeatures: keyFeatures,
      mainImage: mainImage ?? "",
      gallery: gallery ?? [],
      videoUrl: videoUrl,
      regularPrice: regularPrice ?? "",
      localTransitFee: localTransitFee ?? "",
      salePrice: salePrice ?? "",
      currency: currency,
      availableStock: availableStock ?? -1,
      lowStockAlert: lowStockAlert ?? -1,
      purchaseLimit: purchaseLimit,
      commissionPercentage: commissionPercentage ?? "",
      weight: weight ?? "",
      weightUnit: weightUnit ?? "",
      shippingWeight: shippingWeight,
      shippingWeightUnit: shippingWeightUnit ?? "",
      dimensions: dimensions!.toEntity(),
      packagingDimensions: packagingDimensions,
      packagingDetails:
          packagingDetails?.map((e) => e.toEntity()).toList() ?? [],
      shippingMethods: shippingMethods ?? "",
      shippingRegion: shippingRegion ?? "",
      shippingCountries: shippingCountries ?? [],
      handlingTime: handlingTime ?? "",
      returnsPolicy: returnsPolicy,
      tags: tags,
      seoTitle: seoTitle,
      metaDescription: metaDescription,
      status: status ?? "",
      publishDate: publishDate,
      visibility: visibility ?? "",
      specificCustomerGroups: specificCustomerGroups,
      lastUpdatedBy: lastUpdatedBy,
      hasVariant: hasVariant ?? false,
      woodenBoxPackaging: woodenBoxPackaging ?? false,
      isPerfume: isPerfume ?? false,
      containsBattery: containsBattery ?? false,
      isCosmetics: isCosmetics ?? false,
      containsMagnet: containsMagnet ?? false,
      selfFulfilled: selfFulfilled ?? false,
      countryOfOrigin: countryOfOrigin ?? "",
      hsCode: hsCode ?? "",
      isMarketplace: isMarketplace ?? false,
      isActive: isActive ?? false,
      createdAt: createdAt ?? "",
      lastUpdatedAt: lastUpdatedAt ?? "",
      seller: seller ?? -1,
      category: category!.toEntity(),
      brand: brand ?? -1,
    );
  }
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<dynamic>? subcategories;
  AllowedAttributes? allowedAttributes;

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
    allowedAttributes:
        json["allowed_attributes"] == null
            ? null
            : AllowedAttributes.fromJson(json["allowed_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories":
        subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x)),
    "allowed_attributes": allowedAttributes?.toJson(),
  };

  WishListDataItemProductCategoryEntity toEntity() {
    return WishListDataItemProductCategoryEntity(
      id: id ?? -1,
      name: name ?? "",
      parent: parent ?? -1,
      subcategories: subcategories ?? [],
      allowedAttributes: allowedAttributes!.toEntity(),
    );
  }
}

class AllowedAttributes {
  List<String>? form;
  List<String>? size;
  List<String>? duration;
  List<String>? skinType;
  List<String>? scentFamily;
  List<String>? alcoholContent;

  AllowedAttributes({
    this.form,
    this.size,
    this.duration,
    this.skinType,
    this.scentFamily,
    this.alcoholContent,
  });

  factory AllowedAttributes.fromRawJson(String str) =>
      AllowedAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllowedAttributes.fromJson(Map<String, dynamic> json) =>
      AllowedAttributes(
        form:
            json["Form"] == null
                ? []
                : List<String>.from(json["Form"]!.map((x) => x)),
        size:
            json["size"] == null
                ? []
                : List<String>.from(json["size"]!.map((x) => x)),
        duration:
            json["Duration"] == null
                ? []
                : List<String>.from(json["Duration"]!.map((x) => x)),
        skinType:
            json["Skin Type"] == null
                ? []
                : List<String>.from(json["Skin Type"]!.map((x) => x)),
        scentFamily:
            json["Scent Family"] == null
                ? []
                : List<String>.from(json["Scent Family"]!.map((x) => x)),
        alcoholContent:
            json["Alcohol Content"] == null
                ? []
                : List<String>.from(json["Alcohol Content"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "Form": form == null ? [] : List<dynamic>.from(form!.map((x) => x)),
    "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
    "Duration":
        duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
    "Skin Type":
        skinType == null ? [] : List<dynamic>.from(skinType!.map((x) => x)),
    "Scent Family":
        scentFamily == null
            ? []
            : List<dynamic>.from(scentFamily!.map((x) => x)),
    "Alcohol Content":
        alcoholContent == null
            ? []
            : List<dynamic>.from(alcoholContent!.map((x) => x)),
  };

  WishListDataItemProductCategoryAllowedAttributesEntity toEntity() {
    return WishListDataItemProductCategoryAllowedAttributesEntity(
      form: form ?? [],
      size: size ?? [],
      duration: duration ?? [],
      skinType: skinType ?? [],
      scentFamily: scentFamily ?? [],
      alcoholContent: alcoholContent ?? [],
    );
  }
}

class Dimensions {
  Measurement? width;
  Measurement? height;
  Measurement? length;

  Dimensions({this.width, this.height, this.length});

  factory Dimensions.fromRawJson(String str) =>
      Dimensions.fromJson(json.decode(str));

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: json["width"] == null ? null : Measurement.fromJson(json["width"]),
    height:
        json["height"] == null ? null : Measurement.fromJson(json["height"]),
    length:
        json["length"] == null ? null : Measurement.fromJson(json["length"]),
  );

  WishListDataItemProductDimensionsEntity toEntity() {
    return WishListDataItemProductDimensionsEntity(
      width: width!.toEntity(),
      height: height!.toEntity(),
      length: length!.toEntity(),
    );
  }
}

class Measurement {
  String? unit;
  double? value;

  Measurement({this.unit, this.value});

  factory Measurement.fromRawJson(String str) =>
      Measurement.fromJson(json.decode(str));

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      Measurement(unit: json["unit"], value: json["value"]?.toDouble());

  WishlistMeasurement toEntity() {
    return WishlistMeasurement(unit: unit ?? "", value: value ?? -1);
  }
}

class PackagingDetail {
  Measurement? width;
  Measurement? height;
  Measurement? length;
  Measurement? weight;
  String? woodenBoxPackaging;

  PackagingDetail({
    this.width,
    this.height,
    this.length,
    this.weight,
    this.woodenBoxPackaging,
  });

  factory PackagingDetail.fromRawJson(String str) =>
      PackagingDetail.fromJson(json.decode(str));

  factory PackagingDetail.fromJson(
    Map<String, dynamic> json,
  ) => PackagingDetail(
    width: json["width"] == null ? null : Measurement.fromJson(json["width"]),
    height:
        json["height"] == null ? null : Measurement.fromJson(json["height"]),
    length:
        json["length"] == null ? null : Measurement.fromJson(json["length"]),
    weight:
        json["weight"] == null ? null : Measurement.fromJson(json["weight"]),
    woodenBoxPackaging: json["wooden_box_packaging"],
  );

  WishListDataItemProductPackagingDetailEntity toEntity() {
    return WishListDataItemProductPackagingDetailEntity(
      width: width!.toEntity(),
      height: height!.toEntity(),
      length: length!.toEntity(),
      weight: weight!.toEntity(),
      woodenBoxPackaging: woodenBoxPackaging ?? "",
    );
  }
}
