import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';

class CartModel {
  final String status;
  final String message;
  final CartDataModel? data;

  const CartModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json["status"]?.toString() ?? "error",
      message: json["message"]?.toString() ?? "",
      data: json["data"] != null ? CartDataModel.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  bool get isSuccess => status.toLowerCase() == "success";
  bool get hasData => data != null;

  CartEntity? toEntity() {
    return data?.toEntity();
  }
}

class CartDataModel {
  final int id;
  final dynamic customer;
  final String sessionKey;
  final String createdAt;
  final List<CartItemModel> items;

  const CartDataModel({
    required this.id,
    required this.customer,
    required this.sessionKey,
    required this.createdAt,
    required this.items,
  });

  factory CartDataModel.fromRawJson(String str) =>
      CartDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json["id"] as int? ?? 0,
      customer: json["customer"],
      sessionKey: json["session_key"]?.toString() ?? "",
      createdAt: json["created_at"]?.toString() ?? "",
      items: (json["items"] as List<dynamic>?)
          ?.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "session_key": sessionKey,
    "created_at": createdAt,
    "items": items.map((item) => item.toJson()).toList(),
  };

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      customer: customer,
      sessionKey: sessionKey,
      createdAt: _parseDateTime(createdAt),
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}

class CartItemModel {
  final int id;
  final int cart;
  final ProductModel product;
  final ProductVariantModel? variant;
  final int quantity;
  final dynamic voucherCode;
  final String discountAmount;
  final String addedAt;
  final bool isChecked;

  const CartItemModel({
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

  factory CartItemModel.fromRawJson(String str) =>
      CartItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["id"] as int? ?? 0,
      cart: json["cart"] as int? ?? 0,
      product: ProductModel.fromJson(json["product"] as Map<String, dynamic>? ?? {}),
      variant: json["variant"] != null
          ? ProductVariantModel.fromJson(json["variant"] as Map<String, dynamic>)
          : null,
      quantity: json["quantity"] as int? ?? 1,
      voucherCode: json["voucher_code"],
      discountAmount: json["discount_amount"]?.toString() ?? "0",
      addedAt: json["added_at"]?.toString() ?? "",
      isChecked: json["is_checked"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart": cart,
    "product": product.toJson(),
    "variant": variant?.toJson(),
    "quantity": quantity,
    "voucher_code": voucherCode,
    "discount_amount": discountAmount,
    "added_at": addedAt,
    "is_checked": isChecked,
  };

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      cart: cart,
      product: product.toEntity(),
      variant: variant?.toEntity(),
      quantity: quantity,
      voucherCode: voucherCode?.toString(),
      discountAmount: _parseDouble(discountAmount) ?? 0.0,
      addedAt: _parseDateTime(addedAt),
      isChecked: isChecked,
    );
  }
}

class ProductModel {
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
  final int purchaseLimit;
  final dynamic commissionPercentage;
  final String weight;
  final String weightUnit;
  final dynamic shippingWeight;
  final String shippingWeightUnit;
  final DimensionsModel dimensions;
  final DimensionsModel packagingDimensions;
  final List<DimensionsModel> packagingDetails;
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
  final dynamic technicalSpecifications;
  final bool hasVariant;
  final bool woodenBoxPackaging;
  final bool isPerfume;
  final bool containsBattery;
  final bool isCosmetics;
  final bool containsMagnet;
  final String countryOfOrigin;
  final dynamic hsCode;
  final bool isActive;
  final String createdAt;
  final String lastUpdatedAt;
  final int seller;
  final CategoryModel? category;
  final int brand;

  const ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    this.modelNumber,
    required this.productType,
    required this.badge,
    required this.shortDescription,
    required this.longDescription,
    this.keyFeatures,
    required this.mainImage,
    required this.gallery,
    this.videoUrl,
    required this.regularPrice,
    required this.localTransitFee,
    required this.salePrice,
    this.currency,
    required this.availableStock,
    required this.lowStockAlert,
    required this.purchaseLimit,
    this.commissionPercentage,
    required this.weight,
    required this.weightUnit,
    this.shippingWeight,
    required this.shippingWeightUnit,
    required this.dimensions,
    required this.packagingDimensions,
    required this.packagingDetails,
    required this.shippingMethods,
    required this.shippingRegion,
    required this.shippingCountries,
    required this.handlingTime,
    this.returnsPolicy,
    this.tags,
    this.seoTitle,
    this.metaDescription,
    required this.status,
    this.publishDate,
    required this.visibility,
    this.specificCustomerGroups,
    this.lastUpdatedBy,
    this.technicalSpecifications,
    required this.hasVariant,
    required this.woodenBoxPackaging,
    required this.isPerfume,
    required this.containsBattery,
    required this.isCosmetics,
    required this.containsMagnet,
    required this.countryOfOrigin,
    this.hsCode,
    required this.isActive,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.seller,
    this.category,
    required this.brand,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      sku: json["sku"]?.toString() ?? "",
      modelNumber: json["model_number"],
      productType: json["product_type"]?.toString() ?? "",
      badge: json["badge"]?.toString() ?? "",
      shortDescription: json["short_description"]?.toString() ?? "",
      longDescription: json["long_description"]?.toString() ?? "",
      keyFeatures: json["key_features"],
      mainImage: json["main_image"]?.toString() ?? "",
      gallery: _parseStringList(json["gallery"]),
      videoUrl: json["video_url"],
      regularPrice: json["regular_price"]?.toString() ?? "0",
      localTransitFee: json["local_transit_fee"]?.toString() ?? "0",
      salePrice: json["sale_price"]?.toString() ?? "0",
      currency: json["currency"],
      availableStock: json["available_stock"] as int? ?? 0,
      lowStockAlert: json["low_stock_alert"] as int? ?? 0,
      purchaseLimit: json["purchase_limit"] as int? ?? 0,
      commissionPercentage: json["commission_percentage"],
      weight: json["weight"]?.toString() ?? "0",
      weightUnit: json["weight_unit"]?.toString() ?? "",
      shippingWeight: json["shipping_weight"],
      shippingWeightUnit: json["shipping_weight_unit"]?.toString() ?? "",
      dimensions: DimensionsModel.fromJson(json["dimensions"] as Map<String, dynamic>? ?? {}),
      packagingDimensions: DimensionsModel.fromJson(json["packaging_dimensions"] as Map<String, dynamic>? ?? {}),
      packagingDetails: (json["packaging_details"] as List<dynamic>?)
          ?.map((detail) => DimensionsModel.fromJson(detail as Map<String, dynamic>))
          .toList() ?? [],
      shippingMethods: json["shipping_methods"]?.toString() ?? "",
      shippingRegion: json["shipping_region"]?.toString() ?? "",
      shippingCountries: _parseStringList(json["shipping_countries"]),
      handlingTime: json["handling_time"]?.toString() ?? "0",
      returnsPolicy: json["returns_policy"],
      tags: json["tags"],
      seoTitle: json["seo_title"],
      metaDescription: json["meta_description"],
      status: json["status"]?.toString() ?? "",
      publishDate: json["publish_date"],
      visibility: json["visibility"]?.toString() ?? "",
      specificCustomerGroups: json["specific_customer_groups"],
      lastUpdatedBy: json["last_updated_by"],
      technicalSpecifications: json["technical_specifications"],
      hasVariant: json["has_variant"] as bool? ?? false,
      woodenBoxPackaging: json["wooden_box_packaging"] as bool? ?? false,
      isPerfume: json["is_perfume"] as bool? ?? false,
      containsBattery: json["contains_battery"] as bool? ?? false,
      isCosmetics: json["is_cosmetics"] as bool? ?? false,
      containsMagnet: json["contains_magnet"] as bool? ?? false,
      countryOfOrigin: json["country_of_origin"]?.toString() ?? "",
      hsCode: json["hs_code"],
      isActive: json["is_active"] as bool? ?? true,
      createdAt: json["created_at"]?.toString() ?? "",
      lastUpdatedAt: json["last_updated_at"]?.toString() ?? "",
      seller: json["seller"] as int? ?? 0,
      category: json["category"] != null
          ? CategoryModel.fromJson(json["category"] as Map<String, dynamic>)
          : null,
      brand: json["brand"] as int? ?? 0,
    );
  }

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
    "gallery": gallery,
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
    "dimensions": dimensions.toJson(),
    "packaging_dimensions": packagingDimensions.toJson(),
    "packaging_details": packagingDetails.map((detail) => detail.toJson()).toList(),
    "shipping_methods": shippingMethods,
    "shipping_region": shippingRegion,
    "shipping_countries": shippingCountries,
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
    "technical_specifications": technicalSpecifications,
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

  CartItemProductEntity toEntity() {
    return CartItemProductEntity(
      id: id,
      name: name,
      sku: sku,
      modelNumber: modelNumber?.toString(),
      productType: ProductType.fromString(productType),
      badge: badge,
      shortDescription: shortDescription,
      longDescription: longDescription,
      keyFeatures: _parseStringList(keyFeatures),
      mainImage: mainImage,
      gallery: gallery,
      videoUrl: videoUrl?.toString(),
      regularPrice: _parseDouble(regularPrice) ?? 0.0,
      localTransitFee: _parseDouble(localTransitFee) ?? 0.0,
      salePrice: _parseDouble(salePrice) ?? 0.0,
      currency: currency?.toString() ?? "USD",
      availableStock: availableStock,
      lowStockAlert: lowStockAlert,
      purchaseLimit: purchaseLimit,
      commissionPercentage: _parseDouble(commissionPercentage?.toString()),
      weight: MeasurementEntity(
        unit: weightUnit,
        value: _parseDouble(weight) ?? 0.0,
      ),
      shippingWeight: shippingWeight != null
          ? MeasurementEntity(
        unit: shippingWeightUnit,
        value: _parseDouble(shippingWeight.toString()) ?? 0.0,
      )
          : null,
      dimensions: dimensions.toEntity(),
      packagingDimensions: packagingDimensions.toEntity(),
      packagingDetails: packagingDetails.map((detail) => detail.toEntity()).toList(),
      shippingMethods: _parseShippingMethods(shippingMethods),
      shippingRegion: shippingRegion,
      shippingCountries: shippingCountries,
      handlingTime: Duration(days: int.tryParse(handlingTime) ?? 0),
      returnsPolicy: returnsPolicy?.toString(),
      tags: _parseStringList(tags),
      seoTitle: seoTitle?.toString(),
      metaDescription: metaDescription?.toString(),
      status: ProductStatus.fromString(status),
      publishDate: publishDate != null ? _parseDateTime(publishDate.toString()) : null,
      visibility: ProductVisibility.fromString(visibility),
      specificCustomerGroups: _parseStringList(specificCustomerGroups),
      lastUpdatedBy: lastUpdatedBy?.toString(),
      technicalSpecifications: technicalSpecifications as Map<String, dynamic>? ?? {},
      attributes: ProductAttributesEntity(
        hasVariant: hasVariant,
        woodenBoxPackaging: woodenBoxPackaging,
        isPerfume: isPerfume,
        containsBattery: containsBattery,
        isCosmetics: isCosmetics,
        containsMagnet: containsMagnet,
      ),
      countryOfOrigin: countryOfOrigin,
      hsCode: hsCode?.toString(),
      isActive: isActive,
      createdAt: _parseDateTime(createdAt),
      lastUpdatedAt: _parseDateTime(lastUpdatedAt),
      seller: seller,
      category: category?.toEntity(),
      brand: brand,
    );
  }
}

class ProductVariantModel {
  final String? size;
  final String? color;
  final String? material;
  final String? style;
  final String? name;
  final String? sku;
  final String? modelNumber;
  final String? mainImage;
  final dynamic regularPrice;
  final dynamic salePrice;
  final String? currency;
  final dynamic availableStock;
  final dynamic weight;
  final dynamic weightUnit;
  final dynamic packagingDetails;
  final bool? woodenBoxPackaging;
  final bool? isPerfume;
  final bool? containsBattery;
  final bool? isCosmetics;
  final bool? containsMagnet;
  final String? hsCode;
  final bool? isActive;

  const ProductVariantModel({
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
    this.currency,
    this.availableStock,
    this.weight,
    this.weightUnit,
    this.packagingDetails,
    this.woodenBoxPackaging,
    this.isPerfume,
    this.containsBattery,
    this.isCosmetics,
    this.containsMagnet,
    this.hsCode,
    this.isActive,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      size: json["size"]?.toString(),
      color: json["color"]?.toString(),
      material: json["material"]?.toString(),
      style: json["style"]?.toString(),
      name: json["name"]?.toString(),
      sku: json["sku"]?.toString(),
      modelNumber: json["model_number"]?.toString(),
      mainImage: json["main_image"]?.toString(),
      regularPrice: json["regular_price"],
      salePrice: json["sale_price"],
      currency: json["currency"]?.toString(),
      availableStock: json["available_stock"],
      weight: json["weight"],
      weightUnit: json["weight_unit"]?.toString(),
      packagingDetails: json["packaging_details"],
      woodenBoxPackaging: json["wooden_box_packaging"] as bool?,
      isPerfume: json["is_perfume"] as bool?,
      containsBattery: json["contains_battery"] as bool?,
      isCosmetics: json["is_cosmetics"] as bool?,
      containsMagnet: json["contains_magnet"] as bool?,
      hsCode: json["hs_code"]?.toString(),
      isActive: json["is_active"] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    "size": size,
    "color": color,
    "material": material,
    "style": style,
    "name": name,
    "sku": sku,
    "model_number": modelNumber,
    "main_image": mainImage,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "currency": currency,
    "available_stock": availableStock,
    "weight": weight,
    "weight_unit": weightUnit,
    "packaging_details": packagingDetails,
    "wooden_box_packaging": woodenBoxPackaging,
    "is_perfume": isPerfume,
    "contains_battery": containsBattery,
    "is_cosmetics": isCosmetics,
    "contains_magnet": containsMagnet,
    "hs_code": hsCode,
    "is_active": isActive,
  };

  CartItemVariantEntity toEntity() {
    return CartItemVariantEntity(
      size: size,
      color: color,
      material: material,
      style: style,
      name: name,
      sku: sku,
      modelNumber: modelNumber,
      mainImage: mainImage,
      regularPrice: _parseDouble(regularPrice?.toString()),
      salePrice: _parseDouble(salePrice?.toString()),
      currency: currency ?? "USD",
      availableStock: availableStock as int?,
      weight: weight != null && weightUnit != null
          ? MeasurementEntity(
        unit: weightUnit!,
        value: _parseDouble(weight.toString()) ?? 0.0,
      )
          : null,
      packagingDetails: packagingDetails != null
          ? (packagingDetails as List<dynamic>)
          .map((detail) => DimensionsModel.fromJson(detail as Map<String, dynamic>).toEntity())
          .toList()
          : null,
      attributes: ProductAttributesEntity(
        hasVariant: true,
        woodenBoxPackaging: woodenBoxPackaging ?? false,
        isPerfume: isPerfume ?? false,
        containsBattery: containsBattery ?? false,
        isCosmetics: isCosmetics ?? false,
        containsMagnet: containsMagnet ?? false,
      ),
      hsCode: hsCode,
      isActive: isActive ?? true,
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final int? parent;
  final List<dynamic> subcategories;
  final dynamic allowedAttributes;

  const CategoryModel({
    required this.id,
    required this.name,
    this.parent,
    required this.subcategories,
    this.allowedAttributes,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"] as int? ?? 0,
      name: json["name"]?.toString() ?? "",
      parent: json["parent"] as int?,
      subcategories: json["subcategories"] as List<dynamic>? ?? [],
      allowedAttributes: json["allowed_attributes"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories": subcategories,
    "allowed_attributes": allowedAttributes,
  };

  CartItemProductCategoryEntity toEntity() {
    return CartItemProductCategoryEntity(
      id: id,
      name: name,
      parent: parent,
      subcategories: subcategories,
      allowedAttributes: allowedAttributes,
    );
  }
}

class DimensionsModel {
  final HeightModel? width;
  final HeightModel? height;
  final HeightModel? length;
  final HeightModel? weight;

  const DimensionsModel({
    this.width,
    this.height,
    this.length,
    this.weight,
  });

  factory DimensionsModel.fromRawJson(String str) =>
      DimensionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      width: json["width"] != null ? HeightModel.fromJson(json["width"]) : null,
      height: json["height"] != null ? HeightModel.fromJson(json["height"]) : null,
      length: json["length"] != null ? HeightModel.fromJson(json["length"]) : null,
      weight: json["weight"] != null ? HeightModel.fromJson(json["weight"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "width": width?.toJson(),
    "height": height?.toJson(),
    "length": length?.toJson(),
    "weight": weight?.toJson(),
  };

  CartItemProductDimensionsEntity toEntity() {
    return CartItemProductDimensionsEntity(
      width: width?.toEntity() ?? MeasurementEntity(unit: "", value: 0.0),
      height: height?.toEntity() ?? MeasurementEntity(unit: "", value: 0.0),
      length: length?.toEntity() ?? MeasurementEntity(unit: "", value: 0.0),
      weight: weight?.toEntity() ?? MeasurementEntity(unit: "", value: 0.0),
    );
  }
}

class HeightModel {
  final String unit;
  final String value;

  const HeightModel({
    required this.unit,
    required this.value,
  });

  factory HeightModel.fromRawJson(String str) =>
      HeightModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HeightModel.fromJson(Map<String, dynamic> json) {
    return HeightModel(
      unit: json["unit"]?.toString() ?? "",
      value: json["value"]?.toString() ?? "0",
    );
  }

  Map<String, dynamic> toJson() => {
    "unit": unit,
    "value": value,
  };

  MeasurementEntity toEntity() {
    return MeasurementEntity(
      unit: unit,
      value: _parseDouble(value) ?? 0.0,
    );
  }
}

// Utility functions
DateTime _parseDateTime(String? value) {
  if (value == null || value.isEmpty) return DateTime.now();
  try {
    return DateTime.parse(value);
  } catch (e) {
    return DateTime.now();
  }
}

double? _parseDouble(String? value) {
  if (value == null || value.isEmpty) return null;
  try {
    return double.parse(value);
  } catch (e) {
    return null;
  }
}

List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List<String>) return value;
  if (value is List<dynamic>) {
    return value.map((item) => item?.toString() ?? "").where((item) => item.isNotEmpty).toList();
  }
  if (value is String && value.isNotEmpty) return [value];
  return [];
}

List<ShippingMethod> _parseShippingMethods(String? value) {
  if (value == null || value.isEmpty) return [];
  return value.split(',')
      .map((method) => ShippingMethod.fromString(method.trim()))
      .toList();
}