class CategoriesEntity {
  final String status;
  final List<SubCategoriesEntity> data;

  CategoriesEntity({required this.status, required this.data});
}

class SubCategoriesEntity {
  final String name;
  final String handle;
  final List<SubCategoriesEntity> subcategories;
  bool isExpanded;

  SubCategoriesEntity({
    required this.name,
    required this.handle,
    required this.subcategories,
    this.isExpanded = false,
  });
}
