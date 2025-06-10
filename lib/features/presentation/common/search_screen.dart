import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/search/search_result_autocomplete_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/marketplace/cubit/category_cubit.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  SearchResultAutoCompleteEntity? searchResult;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is ProductViewLoaded) {
            context.pop();
            context.push(AppRoutes.productRoute, extra: state.productEntity);
          } else if (state is CategoryError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: AppColors.black70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: AppColors.black70),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      callSearchApi(text);
                    } else {
                      callSearchApi("");
                    }
                  },
                ),
                SizedBox(height: 20),
                BlocConsumer<CommonCubit, CommonState>(
                  listener: (context, state) {
                    if (state is SearchAutoCompleteLoaded) {
                      searchResult = state.entity;
                    }
                  },
                  builder: (context, state) {
                    return searchResult != null
                        ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black70),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              searchResult!.productSuggestions.isNotEmpty
                                  ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          _callProductViewApi(
                                            searchResult!
                                                .productSuggestions[index]
                                                .id,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                child: Image.network(
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.contain,
                                                  searchResult!
                                                      .productSuggestions[index]
                                                      .mainImage,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  searchResult
                                                          ?.productSuggestions[index]
                                                          .name ??
                                                      "",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        searchResult?.productSuggestions.length,
                                  )
                                  : SizedBox(),
                              searchResult!.searchTerms.isNotEmpty
                                  ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // context
                                          //     .push(
                                          //   AppRoutes
                                          //       .listingRoute,
                                          //   extra: searchResult!.searchTerms[index],
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          child: Text(
                                            searchResult!.searchTerms[index],
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: searchResult?.searchTerms.length,
                                  )
                                  : SizedBox(),
                            ],
                          ),
                        )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callSearchApi(String text) {
    context.read<CommonCubit>().search(query: text);
  }

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }
}
