class RelatedProductsEntity {
  final String status;
  final String message;
  final List<RelatedProductsDataEntity> data;

  RelatedProductsEntity({
    required this.status,
    required this.message,
    required this.data,
  });

}

class RelatedProductsDataEntity {
  final String id;
  final String name;
  final String sku;
  final String productType;
  final String regularPrice;
  final String mainImage;
  final RelatedProductsCategoryEntity category;
  final RelatedProductsBrandEntity brand;
  final String salePrice;
  final List<dynamic> reviews;
  final RelatedProductsSellerEntity seller;
  final String hsCode;

  RelatedProductsDataEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.productType,
    required this.regularPrice,
    required this.mainImage,
    required this.category,
    required this.brand,
    required this.salePrice,
    required this.reviews,
    required this.seller,
    required this.hsCode,
  });

}

class RelatedProductsBrandEntity {
  final int id;
  final String name;
  final dynamic description;

  RelatedProductsBrandEntity({
    required this.id,
    required this.name,
    required this.description,
  });

}

class RelatedProductsCategoryEntity {
  final int id;
  final String name;
  final int parent;
  final List<dynamic> subcategories;
  final RelatedProductsAllowedAttributesEntity allowedAttributes;

  RelatedProductsCategoryEntity({
    required this.id,
    required this.name,
    required this.parent,
    required this.subcategories,
    required this.allowedAttributes,
  });

}

class RelatedProductsAllowedAttributesEntity {
  final List<String> form;
  final List<String> size;
  final List<String> duration;
  final List<String> skinType;
  final List<String> scentFamily;
  final List<String> alcoholContent;

  RelatedProductsAllowedAttributesEntity({
    required this.form,
    required this.size,
    required this.duration,
    required this.skinType,
    required this.scentFamily,
    required this.alcoholContent,
  });

}

class RelatedProductsSellerEntity {
  final int id;
  final String businessName;
  final bool isHiddenGem;

  RelatedProductsSellerEntity({
    required this.id,
    required this.businessName,
    required this.isHiddenGem,
  });

}
