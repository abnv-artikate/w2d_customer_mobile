class RecommendationsEntity {
  final String status;
  final String message;
  final List<RecommendationsDataEntity> data;

  RecommendationsEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class RecommendationsDataEntity {
  final String id;
  final String name;
  final String sku;
  final String productType;
  final String regularPrice;
  final String mainImage;
  final RecommendationsCategoryEntity category;
  final RecommendationsBrandEntity brand;
  final String salePrice;
  final List<dynamic> reviews;
  final RecommendationsSellerEntity seller;
  final String hsCode;

  RecommendationsDataEntity({
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

class RecommendationsBrandEntity {
  final int id;
  final String name;
  final dynamic description;

  RecommendationsBrandEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class RecommendationsCategoryEntity {
  final int id;
  final String name;
  final int parent;
  final List<dynamic> subcategories;
  final RecommendationsAllowedAttributesEntity allowedAttributes;

  RecommendationsCategoryEntity({
    required this.id,
    required this.name,
    required this.parent,
    required this.subcategories,
    required this.allowedAttributes,
  });
}

class RecommendationsAllowedAttributesEntity {
  final List<String> form;
  final List<String> size;
  final List<String> duration;
  final List<String> skinType;
  final List<String> scentFamily;
  final List<String> alcoholContent;

  RecommendationsAllowedAttributesEntity({
    required this.form,
    required this.size,
    required this.duration,
    required this.skinType,
    required this.scentFamily,
    required this.alcoholContent,
  });
}

class RecommendationsSellerEntity {
  final int id;
  final String businessName;
  final bool isHiddenGem;

  RecommendationsSellerEntity({
    required this.id,
    required this.businessName,
    required this.isHiddenGem,
  });
}
