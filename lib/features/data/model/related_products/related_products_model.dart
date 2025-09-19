import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/related_products/related_products_entity.dart';

class RelatedProductsModel {
  String? status;
  String? message;
  List<RelatedProductsDataModel>? data;

  RelatedProductsModel({this.status, this.message, this.data});

  factory RelatedProductsModel.fromRawJson(String str) =>
      RelatedProductsModel.fromJson(json.decode(str));

  factory RelatedProductsModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<RelatedProductsDataModel>.from(
                  json["data"]!.map(
                    (x) => RelatedProductsDataModel.fromJson(x),
                  ),
                ),
      );

  RelatedProductsEntity toEntity() {
    return RelatedProductsEntity(
      status: status ?? "",
      message: message ?? "",
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class RelatedProductsDataModel {
  String? id;
  String? name;
  String? sku;
  String? productType;
  String? regularPrice;
  String? mainImage;
  RelatedProductsCategoryModel? category;
  RelatedProductsBrandModel? brand;
  String? salePrice;
  List<dynamic>? reviews;
  RelatedProductsSellerModel? seller;
  String? hsCode;

  RelatedProductsDataModel({
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

  factory RelatedProductsDataModel.fromRawJson(String str) =>
      RelatedProductsDataModel.fromJson(json.decode(str));

  factory RelatedProductsDataModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsDataModel(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        productType: json["product_type"],
        regularPrice: json["regular_price"],
        mainImage: json["main_image"],
        category:
            json["category"] == null
                ? null
                : RelatedProductsCategoryModel.fromJson(json["category"]),
        brand:
            json["brand"] == null
                ? null
                : RelatedProductsBrandModel.fromJson(json["brand"]),
        salePrice: json["sale_price"],
        reviews:
            json["reviews"] == null
                ? []
                : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        seller:
            json["seller"] == null
                ? null
                : RelatedProductsSellerModel.fromJson(json["seller"]),
        hsCode: json["hs_code"],
      );

  RelatedProductsDataEntity toEntity() {
    return RelatedProductsDataEntity(
      id: id ?? "",
      name: name ?? "",
      sku: sku ?? "",
      productType: productType ?? "",
      regularPrice: regularPrice ?? "",
      mainImage: mainImage ?? "",
      category: category!.toEntity(),
      brand: brand!.toEntity(),
      salePrice: salePrice ?? "",
      reviews: reviews ?? [],
      seller: seller!.toEntity(),
      hsCode: hsCode ?? "",
    );
  }
}

class RelatedProductsBrandModel {
  int? id;
  String? name;
  dynamic description;

  RelatedProductsBrandModel({this.id, this.name, this.description});

  factory RelatedProductsBrandModel.fromRawJson(String str) =>
      RelatedProductsBrandModel.fromJson(json.decode(str));

  factory RelatedProductsBrandModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsBrandModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  RelatedProductsBrandEntity toEntity() {
    return RelatedProductsBrandEntity(
      id: id ?? -1,
      name: name ?? "",
      description: description,
    );
  }
}

class RelatedProductsCategoryModel {
  int? id;
  String? name;
  int? parent;
  List<dynamic>? subcategories;
  RelatedProductsAllowedAttributesModel? allowedAttributes;

  RelatedProductsCategoryModel({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    this.allowedAttributes,
  });

  factory RelatedProductsCategoryModel.fromRawJson(String str) =>
      RelatedProductsCategoryModel.fromJson(json.decode(str));

  factory RelatedProductsCategoryModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsCategoryModel(
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
                : RelatedProductsAllowedAttributesModel.fromJson(
                  json["allowed_attributes"],
                ),
      );

  RelatedProductsCategoryEntity toEntity() {
    return RelatedProductsCategoryEntity(
      id: id ?? -1,
      name: name ?? "",
      parent: parent ?? -1,
      subcategories: subcategories ?? [],
      allowedAttributes: allowedAttributes!.toEntity(),
    );
  }
}

class RelatedProductsAllowedAttributesModel {
  List<String>? form;
  List<String>? size;
  List<String>? duration;
  List<String>? skinType;
  List<String>? scentFamily;
  List<String>? alcoholContent;

  RelatedProductsAllowedAttributesModel({
    this.form,
    this.size,
    this.duration,
    this.skinType,
    this.scentFamily,
    this.alcoholContent,
  });

  factory RelatedProductsAllowedAttributesModel.fromRawJson(String str) =>
      RelatedProductsAllowedAttributesModel.fromJson(json.decode(str));

  factory RelatedProductsAllowedAttributesModel.fromJson(
    Map<String, dynamic> json,
  ) => RelatedProductsAllowedAttributesModel(
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

  RelatedProductsAllowedAttributesEntity toEntity() {
    return RelatedProductsAllowedAttributesEntity(
      form: form ?? [],
      size: size ?? [],
      duration: duration ?? [],
      skinType: skinType ?? [],
      scentFamily: scentFamily ?? [],
      alcoholContent: alcoholContent ?? [],
    );
  }
}

class RelatedProductsSellerModel {
  int? id;
  String? businessName;
  bool? isHiddenGem;

  RelatedProductsSellerModel({this.id, this.businessName, this.isHiddenGem});

  factory RelatedProductsSellerModel.fromRawJson(String str) =>
      RelatedProductsSellerModel.fromJson(json.decode(str));

  factory RelatedProductsSellerModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsSellerModel(
        id: json["id"],
        businessName: json["business_name"],
        isHiddenGem: json["is_hidden_gem"],
      );

  RelatedProductsSellerEntity toEntity() {
    return RelatedProductsSellerEntity(
      id: id ?? -1,
      businessName: businessName ?? "",
      isHiddenGem: isHiddenGem ?? false,
    );
  }
}
