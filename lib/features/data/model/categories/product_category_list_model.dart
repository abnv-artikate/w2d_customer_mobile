import 'dart:convert';

class ProductCategoryListModel {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  ProductCategoryListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ProductCategoryListModel.fromRawJson(String str) =>
      ProductCategoryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryListModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryListModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            json["results"] == null
                ? []
                : List<Result>.from(
                  json["results"]!.map((x) => Result.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results":
        results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? name;
  String? sku;
  String? productType;
  String? regularPrice;
  String? mainImage;
  Category? category;
  Brand? brand;
  String? salePrice;
  List<dynamic>? reviews;
  Seller? seller;

  Result({
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
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    sku: json["sku"],
    productType: json["product_type"],
    regularPrice: json["regular_price"],
    mainImage: json["main_image"],
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    salePrice: json["sale_price"],
    reviews:
        json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "product_type": productType,
    "regular_price": regularPrice,
    "main_image": mainImage,
    "category": category?.toJson(),
    "brand": brand?.toJson(),
    "sale_price": salePrice,
    "reviews":
        reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    "seller": seller?.toJson(),
  };
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Subcategory {
  int? id;
  String? name;
  int? parent;
  List<Category>? subcategories;

  // PurpleAllowedAttributes? allowedAttributes;

  Subcategory({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    // this.allowedAttributes,
  });

  factory Subcategory.fromRawJson(String str) =>
      Subcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
    parent: json["parent"],
    subcategories:
        json["subcategories"] == null
            ? []
            : List<Category>.from(
              json["subcategories"]!.map((x) => Category.fromJson(x)),
            ),
    // allowedAttributes: json["allowed_attributes"] == null ? null : PurpleAllowedAttributes.fromJson(json["allowed_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories":
        subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    // "allowed_attributes": allowedAttributes?.toJson(),
  };
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<Subcategory>? subcategories;

  // CategoryAllowedAttributes? allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    // this.allowedAttributes,
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
            : List<Subcategory>.from(
              json["subcategories"]!.map((x) => Subcategory.fromJson(x)),
            ),
    // allowedAttributes: json["allowed_attributes"] == null ? null : CategoryAllowedAttributes.fromJson(json["allowed_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent": parent,
    "subcategories":
        subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    // "allowed_attributes": allowedAttributes?.toJson(),
  };
}

class Seller {
  int? id;
  String? businessName;
  bool? isHiddenGem;

  Seller({this.id, this.businessName, this.isHiddenGem});

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    businessName: json["business_name"],
    isHiddenGem: json["is_hidden_gem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "is_hidden_gem": isHiddenGem,
  };
}
