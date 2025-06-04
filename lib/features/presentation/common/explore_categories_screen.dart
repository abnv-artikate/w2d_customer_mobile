import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/categories_listing_widget.dart';

class ExploreCategoriesScreen extends StatefulWidget {
  const ExploreCategoriesScreen({super.key});

  @override
  State<ExploreCategoriesScreen> createState() =>
      _ExploreCategoriesScreenState();
}

class _ExploreCategoriesScreenState extends State<ExploreCategoriesScreen> {
  @override
  void initState() {
    _callCategoriesListingAPi();
    super.initState();
  }

  List<SubCategoriesEntity> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CommonCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonCategoriesLoaded) {
            categoryList = state.categoriesList;
          } else if (state is CommonError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          return state is CommonLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.worldGreen),
              )
              : categoryList.isEmpty
              ? Center(child: Text('No Categories to show right now'))
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return CategoriesListingWidget(
                      name: categoryList[index].name,
                      onTap: () {
                        if (categoryList[index].handle.isNotEmpty) {
                          context
                              .push(
                                AppRoutes.listingRoute,
                                extra: categoryList[index].handle,
                              )
                              .then((_) {
                                _callCategoriesListingAPi();
                              });
                        }
                      },
                    );
                  },
                  itemCount: categoryList.length,
                ),
              );
        },
      ),
    );
  }

  void _callCategoriesListingAPi() {
    context.read<CommonCubit>().getCategoriesList();
  }
}
