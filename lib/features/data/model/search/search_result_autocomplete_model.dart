import 'dart:convert';

enum SuggestionType { product, searchTerm }

class Product {
  final String id;
  final String name;
  final String sku;
  final String mainImage;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.mainImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      mainImage: json['main_image']?.toString() ?? '',
    );
  }
}

class SuggestionItem {
  final SuggestionType type;
  final Product? product;
  final String? searchTerm;

  const SuggestionItem._({required this.type, this.product, this.searchTerm});

  factory SuggestionItem.product(Product product) {
    return SuggestionItem._(type: SuggestionType.product, product: product);
  }

  factory SuggestionItem.searchTerm(String term) {
    return SuggestionItem._(type: SuggestionType.searchTerm, searchTerm: term);
  }

  bool get isProduct => type == SuggestionType.product;

  bool get isSearchTerm => type == SuggestionType.searchTerm;
}

class SearchResultAutoCompleteModel {
  final String status;
  final List<SuggestionItem> suggestions;
  final String categoryName;

  const SearchResultAutoCompleteModel({
    required this.status,
    required this.suggestions,
    required this.categoryName,
  });

  factory SearchResultAutoCompleteModel.fromJson(Map<String, dynamic> jsonMap) {
    List<SuggestionItem> suggestionItems = [];
    List<dynamic> suggestionsJson = jsonMap['suggestions'] ?? [];

    for (dynamic suggestion in suggestionsJson) {
      if (suggestion is Map<String, dynamic>) {
        if (_isValidProductMap(suggestion)) {
          Product product = Product.fromJson(suggestion);
          suggestionItems.add(SuggestionItem.product(product));
        }
      } else if (suggestion is String && suggestion.trim().isNotEmpty) {
        suggestionItems.add(SuggestionItem.searchTerm(suggestion.trim()));
      }
    }

    return SearchResultAutoCompleteModel(
      status: jsonMap['status']?.toString() ?? '',
      suggestions: suggestionItems,
      categoryName: jsonMap['category_name']?.toString() ?? '',
    );
  }

  static bool _isValidProductMap(Map<String, dynamic> map) {
    return map.containsKey('id') &&
        map.containsKey('name') &&
        map.containsKey('sku') &&
        map.containsKey('main_image');
  }

  List<Product> get products {
    return suggestions
        .where((item) => item.isProduct)
        .map((item) => item.product!)
        .toList();
  }

  List<String> get searchTerms {
    return suggestions
        .where((item) => item.isSearchTerm)
        .map((item) => item.searchTerm!)
        .toList();
  }
}
