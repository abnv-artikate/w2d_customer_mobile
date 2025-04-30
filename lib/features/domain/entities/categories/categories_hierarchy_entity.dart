class ProductCategoryEntity {
  final int id;
  final String name;
  final String handle;
  final int parent;
  final List<ProductSubCategoryEntity> subCategories;

  ProductCategoryEntity({
    required this.id,
    required this.name,
    required this.handle,
    required this.parent,
    required this.subCategories,
  });
}

class ProductSubCategoryEntity {
  final int id;
  final String name;
  final String handle;
  final int parent;

  ProductSubCategoryEntity({
    required this.id,
    required this.parent,
    required this.name,
    required this.handle,
  });
}
