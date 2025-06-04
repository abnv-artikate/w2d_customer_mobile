import 'dart:convert';

class CategoriesModel {
  String? status;
  List<SubCategoriesModel>? data;

  CategoriesModel({
    this.status,
    this.data,
  });

  factory CategoriesModel.fromRawJson(String str) => CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<SubCategoriesModel>.from(json["data"]!.map((x) => SubCategoriesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubCategoriesModel {
  String? name;
  String? handle;
  List<SubCategoriesModel>? subcategories;

  SubCategoriesModel({
    this.name,
    this.handle,
    this.subcategories,
  });

  factory SubCategoriesModel.fromRawJson(String str) => SubCategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) => SubCategoriesModel(
    name: json["name"],
    handle: json["handle"],
    subcategories: json["subcategories"] == null ? [] : List<SubCategoriesModel>.from(json["subcategories"]!.map((x) => SubCategoriesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "handle": handle,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}
