import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/recommendations/recommendations_entity.dart';

class RecommendationsModel {
  String? status;
  String? message;
  List<RecommendationsDataModel>? data;

  RecommendationsModel({this.status, this.message, this.data});

  factory RecommendationsModel.fromRawJson(String str) =>
      RecommendationsModel.fromJson(json.decode(str));

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<RecommendationsDataModel>.from(
                  json["data"]!.map(
                    (x) => RecommendationsDataModel.fromJson(x),
                  ),
                ),
      );

  RecommendationsEntity toEntity() {
    return RecommendationsEntity(
      status: status ?? "",
      message: message ?? "",
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class RecommendationsDataModel {
  String? id;
  String? name;
  String? sku;
  String? productType;
  String? regularPrice;
  String? mainImage;
  RecommendationsDataCategoryModel? category;
  RecommendationsBrandModel? brand;
  String? salePrice;
  List<dynamic>? reviews;
  RecommendationsDataSellerModel? seller;
  String? hsCode;

  RecommendationsDataModel({
    this.id,
    this.name,
    this.sku,
    this.productType,
    this.regularPrice,
    this.mainImage,
    this.category,
    this.brand,
    this.salePrice,
    this.reviews,
    this.seller,
    this.hsCode,
  });

  factory RecommendationsDataModel.fromRawJson(String str) =>
      RecommendationsDataModel.fromJson(json.decode(str));

  factory RecommendationsDataModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsDataModel(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        productType: json["product_type"],
        regularPrice: json["regular_price"],
        mainImage: json["main_image"],
        category:
            json["category"] == null
                ? null
                : RecommendationsDataCategoryModel.fromJson(json["category"]),
        brand:
            json["brand"] == null
                ? null
                : RecommendationsBrandModel.fromJson(json["brand"]),
        salePrice: json["sale_price"],
        reviews:
            json["reviews"] == null
                ? []
                : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        seller:
            json["seller"] == null
                ? null
                : RecommendationsDataSellerModel.fromJson(json["seller"]),
        hsCode: json["hs_code"],
      );

  RecommendationsDataEntity toEntity() {
    return RecommendationsDataEntity(
      id: id ?? "",
      name: name ?? "",
      sku: sku ?? "",
      productType: productType ?? "",
      regularPrice: regularPrice ?? "",
      mainImage: mainImage ?? "",
      category: category?.toEntity(),
      brand: brand?.toEntity(),
      salePrice: salePrice ?? "",
      reviews: reviews ?? [],
      seller: seller?.toEntity(),
      hsCode: hsCode ?? "",
    );
  }
}

class RecommendationsBrandModel {
  int? id;
  String? name;
  dynamic description;

  RecommendationsBrandModel({this.id, this.name, this.description});

  factory RecommendationsBrandModel.fromRawJson(String str) =>
      RecommendationsBrandModel.fromJson(json.decode(str));

  factory RecommendationsBrandModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsBrandModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  RecommendationsBrandEntity toEntity() {
    return RecommendationsBrandEntity(
      id: id ?? -1,
      name: name ?? "",
      description: description,
    );
  }
}

Map<String, List<String>> parseAllowedAttributes(dynamic raw) {
  if (raw == null) return {};
  if (raw is Map) {
    final Map<String, List<String>> result = {};
    raw.forEach((k, v) {
      if (v == null) {
        result[k.toString()] = [];
      } else if (v is List) {
        result[k.toString()] = v.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
      } else if (v is String || v is num || v is bool) {
        result[k.toString()] = [v.toString()];
      } else if (v is Map) {
        // nested map -> flatten values to strings
        final flat = v.values.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
        result[k.toString()] = flat;
      } else {
        result[k.toString()] = [v.toString()];
      }
    });
    return result;
  }
  return {};
}

class RecommendationsDataCategoryModel {
  int? id;
  String? name;
  int? parent;
  List<dynamic>? subcategories;
  Map<String, List<String>>? allowedAttributes;

  RecommendationsDataCategoryModel({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory RecommendationsDataCategoryModel.fromRawJson(String str) =>
      RecommendationsDataCategoryModel.fromJson(json.decode(str));

  factory RecommendationsDataCategoryModel.fromJson(
    Map<String, dynamic> json,
  ) => RecommendationsDataCategoryModel(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories:
        json["subcategories"] == null
            ? []
            : List<dynamic>.from(json["subcategories"]!.map((x) => x)),
    allowedAttributes: parseAllowedAttributes(json["allowed_attributes"]),
  );

  RecommendationsCategoryEntity toEntity() {
    return RecommendationsCategoryEntity(
      id: id ?? -1,
      name: name ?? "",
      parent: parent ?? -1,
      // subcategories: subcategories ?? [],
      // allowedAttributes: allowedAttributes,
    );
  }
}

class RecommendationsDataAllowedAttributesModel {
  List<String>? form;
  List<String>? size;
  List<String>? duration;
  List<String>? skinType;
  List<String>? scentFamily;
  List<String>? alcoholContent;

  RecommendationsDataAllowedAttributesModel({
    this.form,
    this.size,
    this.duration,
    this.skinType,
    this.scentFamily,
    this.alcoholContent,
  });

  factory RecommendationsDataAllowedAttributesModel.fromRawJson(String str) =>
      RecommendationsDataAllowedAttributesModel.fromJson(json.decode(str));

  factory RecommendationsDataAllowedAttributesModel.fromJson(
    Map<String, dynamic> json,
  ) => RecommendationsDataAllowedAttributesModel(
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
}

class RecommendationsDataSellerModel {
  int? id;
  String? businessName;
  bool? isHiddenGem;

  RecommendationsDataSellerModel({
    this.id,
    this.businessName,
    this.isHiddenGem,
  });

  factory RecommendationsDataSellerModel.fromRawJson(String str) =>
      RecommendationsDataSellerModel.fromJson(json.decode(str));

  factory RecommendationsDataSellerModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsDataSellerModel(
        id: json["id"],
        businessName: json["business_name"],
        isHiddenGem: json["is_hidden_gem"],
      );

  RecommendationsSellerEntity toEntity() {
    return RecommendationsSellerEntity(
      id: id ?? -1,
      businessName: businessName ?? "",
      isHiddenGem: isHiddenGem ?? false,
    );
  }
}
