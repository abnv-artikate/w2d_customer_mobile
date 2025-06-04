import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';

class ProductCategoryListingEntity {
  int count;
  String next;
  dynamic previous;
  List<ResultEntity> results;

  ProductCategoryListingEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

class ResultEntity {
  String id;
  String productName;
  String sku;
  String productType;
  String regularPrice;
  String mainImage;
  SubCategoriesEntity category;
  BrandEntity brand;
  String salePrice;
  List<dynamic> reviews;
  SellerEntity seller;

  ResultEntity({
    required this.id,
    required this.productName,
    required this.sku,
    required this.productType,
    required this.regularPrice,
    required this.mainImage,
    required this.category,
    required this.brand,
    required this.salePrice,
    required this.reviews,
    required this.seller,
  });
}

class BrandEntity {
  int id;
  String name;

  BrandEntity({required this.id, required this.name});
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
