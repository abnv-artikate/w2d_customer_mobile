class BrowsingHistoryEntity {
  final String status;
  final String message;
  final List<BrowsingHistoryDataEntity> data;

  BrowsingHistoryEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class BrowsingHistoryDataEntity {
  final int id;
  final BrowsingHistoryDataProductEntity? product;
  final String viewedAt;

  BrowsingHistoryDataEntity({
    required this.id,
    required this.product,
    required this.viewedAt,
  });
}

class BrowsingHistoryDataProductEntity {
  final String id;
  final String name;
  final String mainImage;
  final String regularPrice;
  final String salePrice;

  BrowsingHistoryDataProductEntity({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.regularPrice,
    required this.salePrice,
  });
}
