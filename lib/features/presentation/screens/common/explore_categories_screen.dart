import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/category_bubble_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/search_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: isSmallScreen ? 20 : 30,

        // title: Text(
        //   'Categories',
        //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        // ),
        // centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: Size.zero,
        //   child: SearchWidget(
        //     onTap: () {
        //       context.push(AppRoutes.searchRoute);
        //     },
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(
              onTap: () {
                context.push(AppRoutes.searchRoute);
              },
            ),
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
                    : GridView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      children:
                          categoryList
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    context
                                        .push(
                                          AppRoutes.listingRoute,
                                          extra: CategoryListingScreenParams(
                                            category: e,
                                          ),
                                        )
                                        .then((_) {
                                          _callCategoriesListingAPi();
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 20,
                                      //   horizontal: 10,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: AppColors.deepBlue),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: CategoryBubble(category: e),
                                  ),
                                ),
                              )
                              .toList(),
                      //   itemCount: categoryList.length,
                      //   itemBuilder: (context, index) {
                      //     return InkWell(
                      //       onTap: () {
                      //         context
                      //             .push(
                      //               AppRoutes.listingRoute,
                      //               extra: CategoryListingScreenParams(
                      //                 category: categoryList[index],
                      //               ),
                      //             )
                      //             .then((_) {
                      //               _callCategoriesListingAPi();
                      //             });
                      //       },
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(
                      //           vertical: 20,
                      //           horizontal: 10,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           // border: Border.all(color: AppColors.deepBlue),
                      //           borderRadius: BorderRadius.circular(4),
                      //         ),
                      //         child: Text(
                      //           categoryList[index].name,
                      //           style: TextStyle(
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                    );
              },
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  void _callCategoriesListingAPi() {
    context.read<CommonCubit>().getCategoriesList();
  }
}
