import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/cart_shipping/cart_shipping_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/category_bubble_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/search_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

final List<String> imgList = [
  Assets.imagesHiddenGemBanners1,
  Assets.imagesHomepageBannersW2D08,
  Assets.imagesHomepageBannersW2D14,
  Assets.imagesHomepageBannersW2D15,
  Assets.imagesHomepageBannersW2D16,
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CollectionsResultDataEntity> collections = [];
  List<SubCategoriesEntity> categoryList = [];

  @override
  void initState() {
    _callGetCollectionsApi();
    _callCategoriesListingAPi();
    _callGetCartItemApi();
    super.initState();
  }

  CarouselOptions get _bannerCarouselOptions {
    return CarouselOptions(
      disableCenter: false,
      height: 200,
      viewportFraction: 0.9,
      autoPlay: true,
      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      enlargeCenterPage: true,
      autoPlayAnimationDuration: Duration(milliseconds: 800),
    );
  }

  CarouselOptions get _categoriesCarouselOption {
    return CarouselOptions(
      disableCenter: true,
      padEnds: false,
      height: 300,
      viewportFraction: 0.45,
      enableInfiniteScroll: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final isSmallScreen = screenWidth < 400;
    return Scaffold(
      appBar: _buildAppBar(),
      // body: NestedScrollView(
      //   headerSliverBuilder:
      //       (context, innerBoxIsScrolled) => [
      //         SliverAppBar(
      //           pinned: true,
      //           stretch: true,
      //           // We don't use toolbar leading/actions; they would stay visible when collapsed.
      //           // Keep the toolbar minimal; the "bottom" holds the Search.
      //           toolbarHeight: kToolbarHeight,
      //           elevation: innerBoxIsScrolled ? 2 : 0,
      //
      //           expandedHeight: kExpandedHeight,
      //
      //           // The expandable area: contains Location + Toggle and the brand gradient.
      //           flexibleSpace: LayoutBuilder(
      //             builder: (context, constraints) {
      //               // How expanded we are (1.0 = fully expanded, 0.0 = fully collapsed)
      //               final double maxH = constraints.maxHeight;
      //               final double collapsibleRange = (kExpandedHeight -
      //                       kToolbarHeight)
      //                   .clamp(1.0, double.infinity);
      //               final double t = ((maxH - kToolbarHeight) /
      //                       collapsibleRange)
      //                   .clamp(0.0, 1.0);
      //
      //               return Stack(
      //                 fit: StackFit.expand,
      //                 children: [
      //                   // Background gradient
      //                   DecoratedBox(
      //                     decoration: BoxDecoration(
      //                       gradient:
      //                           isBrand
      //                               ? AppColors.aspirationGold
      //                               : AppColors.worldGreenGradiant,
      //                     ),
      //                   ),
      //
      //                   // Location + Toggle row — fades out as we collapse
      //                   SafeArea(
      //                     bottom: false,
      //                     child: AnimatedOpacity(
      //                       duration: const Duration(milliseconds: 180),
      //                       opacity: t, // 1 when expanded, 0 when collapsed
      //                       child: Padding(
      //                         padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      //                         child: Align(
      //                           alignment: Alignment.bottomLeft,
      //                           child: Row(
      //                             children: [
      //                               // Location on the left
      //                               Flexible(
      //                                 child: LocationWidget(
      //                                   onTap: () {},
      //                                   address: "Set Location",
      //                                 ),
      //                               ),
      //                               const SizedBox(width: 12),
      //                               // Toggle on the right
      //                               BrandMallToggleWidget(
      //                                 onTap:
      //                                     () =>
      //                                         context
      //                                             .read<CategoryCubit>()
      //                                             .toggleBrand(),
      //                                 isBrand: isBrand,
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             },
      //           ),
      //
      //           // Keep Search pinned (visible both expanded & collapsed)
      //           bottom: PreferredSize(
      //             preferredSize: const Size.fromHeight(kSearchHeight),
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      //               child: SizedBox(
      //                 height: kSearchHeight,
      //                 child: SearchWidget(
      //                   onTap: () => context.push(AppRoutes.searchRoute),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroBanner(),
            _buildBannerSection(),
            _buildCategoriesSection(),
            _buildBannerSection(),
            _buildBestSellers(),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return AppBar(
      toolbarHeight: 150,
      iconTheme: IconThemeData(color: AppColors.deepBlue),
      leadingWidth: isSmallScreen ? screenWidth * 0.5 : screenWidth * 0.7,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: LocationWidget(onTap: () {}, address: "Set Location"),
      ),
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: SearchWidget(
          onTap: () {
            context.push(AppRoutes.searchRoute);
          },
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(Assets.imagesHeroBanner, fit: BoxFit.cover),
    );
  }

  Widget _buildBannerSection() {
    return CarouselSlider(
      options: _bannerCarouselOptions,
      items:
          imgList.map((item) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                item,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(LucideIcons.imageOff, size: 20));
                },
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCategoriesSection() {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonCategoriesLoaded) {
          categoryList = state.categoriesList;
        } else if (state is CommonError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 300,
          alignment: Alignment.center,
          child: GridView(
            padding: EdgeInsets.symmetric(vertical: 20),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 100,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            children:
                categoryList
                    .map(
                      (e) => CategoryBubble(
                        category: e,
                        onTap: () {
                          context
                              .push(
                                AppRoutes.listingRoute,
                                extra: CategoryListingScreenParams(category: e),
                              )
                              .then((_) {
                                _callCategoriesListingAPi();
                              });
                        },
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }

  Widget _buildBestSellers() {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        if (state is CollectionsLoaded) {
          collections = state.collections;
        }
      },
      builder: (context, state) {
        if (collections.isEmpty) {
          return SizedBox();
        }

        return BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is ProductViewLoaded) {
              context.push(AppRoutes.productRoute, extra: state.productEntity);
            }
          },
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _buildCollectionSection(collections[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: collections.length,
          ),
        );
      },
    );
  }

  Widget _buildCollectionSection(CollectionsResultDataEntity collection) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 400 ? 8.0 : 16.0;

    // final carouselItemWidth =
    //     (screenWidth * (screenWidth < 400 ? 0.55 : 0.5)) -
    //     (horizontalPadding * 2);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            collection.name,
            style: TextStyle(
              fontSize: screenWidth < 400 ? 18 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: _categoriesCarouselOption,
            items: List.generate(collection.products.length, (idx) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: ProductItemWidget(
                  isGridView: false,
                  imgUrl: collection.products[idx].mainImage,
                  itemName: collection.products[idx].name,
                  salePrice: collection.products[idx].salePrice,
                  regularPrice: collection.products[idx].regularPrice,
                  onViewTap: () {
                    _callProductViewApi(collection.products[idx].id);
                  },
                  onWishlistTap: () {},
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _callGetCollectionsApi() {
    context.read<CommonCubit>().getCollections();
  }

  void _callCategoriesListingAPi() {
    context.read<CommonCubit>().getCategoriesList();
  }

  void _callProductViewApi(String productId) {
    context.read<CategoryCubit>().getProductView(
      ProductViewParams(productId: productId),
    );
  }

  void _callGetCartItemApi() {
    context.read<CartShippingCubit>().getCartItems();
  }
}
