import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CommonCubit, CommonState>(
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
                      child: CircularProgressIndicator(
                        color: AppColors.worldGreen,
                      ),
                    )
                    : categoryList.isEmpty
                    ? Center(child: Text('No Categories to show right now'))
                    : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context
                                .push(
                                  AppRoutes.listingRoute,
                                  extra: categoryList[index],
                                )
                                .then((_) {
                                  _callCategoriesListingAPi();
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.deepBlue),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                categoryList[index].name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _callCategoriesListingAPi() {
    context.read<CommonCubit>().getCategoriesList();
  }
}
