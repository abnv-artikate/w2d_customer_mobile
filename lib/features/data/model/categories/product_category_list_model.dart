class ProductCategoryListModel {
  String? id;
  String? name;
  String? sku;
  String? productType;
  String? regularPrice;
  String? mainImage;
  Category? category;
  Brand? brand;
  String? salePrice;
  // List<Null>? reviews;
  Seller? seller;

  ProductCategoryListModel({
    this.id,
    this.name,
    this.sku,
    this.productType,
    this.regularPrice,
    this.mainImage,
    this.category,
    this.brand,
    this.salePrice,
    // this.reviews,
    this.seller,
  });

  ProductCategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    productType = json['product_type'];
    regularPrice = json['regular_price'];
    mainImage = json['main_image'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    salePrice = json['sale_price'];
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(Null.fromJson(v));
    //   });
    // }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sku'] = sku;
    data['product_type'] = productType;
    data['regular_price'] = regularPrice;
    data['main_image'] = mainImage;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['sale_price'] = salePrice;
    // if (reviews != null) {
    //   data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    // }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? parent;
  List<Subcategories>? subcategories;
  // AllowedAttributes? allowedAttributes;

  Category({
    this.id,
    this.name,
    this.parent,
    this.subcategories,
    // this.allowedAttributes,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategories.fromJson(v));
      });
    }
    // allowedAttributes =
    //     json['allowed_attributes'] != null
    //         ? AllowedAttributes.fromJson(json['allowed_attributes'])
    //         : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent'] = parent;
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    // if (allowedAttributes != null) {
    //   data['allowed_attributes'] = allowedAttributes!.toJson();
    // }
    return data;
  }
}

class Subcategories {
  int? id;
  String? name;
  int? parent;
  // List<Null>? subcategories;
  // Null? allowedAttributes;

  Subcategories({
    this.id,
    this.name,
    this.parent,
    // this.subcategories,
    // this.allowedAttributes,
  });

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    // if (json['subcategories'] != null) {
    //   subcategories = <Null>[];
    //   json['subcategories'].forEach((v) {
    //     subcategories!.add(Null.fromJson(v));
    //   });
    // }
    // allowedAttributes = json['allowed_attributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent'] = parent;
    // if (subcategories != null) {
    //   data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    // }
    // data['allowed_attributes'] = allowedAttributes;
    return data;
  }
}

class AllowedAttributes {
  List<dynamic>? size;
  List<dynamic>? color;
  List<dynamic>? topNotes;
  List<dynamic>? baseNotes;
  List<dynamic>? heartNotes;

  AllowedAttributes({
    this.size,
    this.color,
    this.topNotes,
    this.baseNotes,
    this.heartNotes,
  });

  AllowedAttributes.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    color = json['color'];
    topNotes = json['Top Notes'];
    baseNotes = json['Base Notes'];
    heartNotes = json['Heart Notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['color'] = color;
    data['Top Notes'] = topNotes;
    data['Base Notes'] = baseNotes;
    data['Heart Notes'] = heartNotes;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  // Null? description;

  Brand({this.id, this.name,
    // this.description
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    // data['description'] = description;
    return data;
  }
}

class Seller {
  int? id;
  String? businessName;
  bool? isHiddenGem;

  Seller({this.id, this.businessName, this.isHiddenGem});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    isHiddenGem = json['is_hidden_gem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_name'] = businessName;
    data['is_hidden_gem'] = isHiddenGem;
    return data;
  }
}
