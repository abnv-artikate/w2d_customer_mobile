import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';

class ProductCategoryListingEntity {
  String id;
  String name;
  String sku;
  String productType;
  String regularPrice;
  String mainImage;
  ProductCategoryEntity category;
  BrandEntity brand;
  String salePrice;

  // List<Null> reviews;
  SellerEntity seller;

  ProductCategoryListingEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.productType,
    required this.regularPrice,
    required this.mainImage,
    required this.category,
    required this.brand,
    required this.salePrice,
    // this.reviews,
    required this.seller,
  });
}

class AllowedAttributesEntity {
  List<String> size;
  List<String> color;
  List<String> topNotes;
  List<String> baseNotes;
  List<String> heartNotes;

  AllowedAttributesEntity({
    required this.size,
    required this.color,
    required this.topNotes,
    required this.baseNotes,
    required this.heartNotes,
  });
}

class BrandEntity {
  int id;
  String name;

  // Null description;

  BrandEntity({
    required this.id,
    required this.name,
    // this.description
  });
}

class SellerEntity {
  int id;
  String businessName;
  bool isHiddenGem;

  SellerEntity({
    required this.id,
    required this.businessName,
    required this.isHiddenGem,
  });
}
