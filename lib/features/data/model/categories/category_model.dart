import 'dart:convert';

class CategoriesModel {
  String? status;
  List<SubCategoriesModel>? data;

  CategoriesModel({this.status, this.data});

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<SubCategoriesModel>.from(
                  json["data"]!.map((x) => SubCategoriesModel.fromJson(x)),
                ),
      );
}

class SubCategoriesModel {
  String? name;
  String? handle;
  String? image;
  List<SubCategoriesModel>? subcategories;

  SubCategoriesModel({this.name, this.handle, this.image, this.subcategories});

  factory SubCategoriesModel.fromRawJson(String str) =>
      SubCategoriesModel.fromJson(json.decode(str));

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        name: json["name"],
        handle: json["handle"],
        image: json["image"],
        subcategories:
            json["subcategories"] == null
                ? []
                : List<SubCategoriesModel>.from(
                  json["subcategories"]!.map(
                    (x) => SubCategoriesModel.fromJson(x),
                  ),
                ),
      );
}
