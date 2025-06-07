class SearchResultAutoCompleteEntity {
  final String status;
  final List<SuggestionClassEntity> productSuggestions;
  final List<String> searchTerms;
  final String categoryName;

  SearchResultAutoCompleteEntity({
    required this.status,
    required this.productSuggestions,
    required this.searchTerms,
    required this.categoryName,
  });

}

class SuggestionClassEntity {
  final String id;
  final String name;
  final String sku;
  final String mainImage;

  SuggestionClassEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.mainImage,
  });

}
