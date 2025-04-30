class CategoryHierarchyModel {
  String? status;
  List<Data>? data;

  CategoryHierarchyModel({this.status, this.data});

  CategoryHierarchyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['handle'] = handle;
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  String? name;
  String? handle;

  // List<Null>? subcategories;

  Subcategories({
    this.name,
    this.handle,
    // this.subcategories
  });

  Subcategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    handle = json['handle'];
    // if (json['subcategories'] != null) {
    //   subcategories = <Null>[];
    //   json['subcategories'].forEach((v) {
    //     subcategories!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['handle'] = handle;
    // if (subcategories != null) {
    //   data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
