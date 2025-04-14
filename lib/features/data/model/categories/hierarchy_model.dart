class CategoriesHierarchyModel {
  String? status;
  List<Data>? data;

  CategoriesHierarchyModel({this.status, this.data});

  CategoriesHierarchyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? name;
  String? handle;
  List<Subcategories>? subcategories;

  Data({this.name, this.handle, this.subcategories});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    handle = json['handle'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategories.fromJson(v));
      });
    }
  }
}

class Subcategories {
  String? name;
  String? handle;
  List<Subcategories>? subcategories;

  Subcategories({this.name, this.handle, this.subcategories});

  Subcategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    handle = json['handle'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategories.fromJson(v));
      });
    }
  }
}
