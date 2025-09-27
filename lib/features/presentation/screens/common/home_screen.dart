import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/marketplace/category_listing_screen.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/category_bubble_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/home_screen_brand_toggle.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/collections_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/brand_mall_toggle_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

final List<String> imgList = [
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
  List<CollectionsResultDataEntity> brandMallCollections = [];
  List<CollectionsResultDataEntity> hiddenGemsCollections = [];
  List<SubCategoriesEntity> categoryList = [];

  @override
  void initState() {
    _callGetCollectionsApi();
    _callCategoriesListingAPi();
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
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    //
    // double carouselHeight;
    // if (screenWidth < 400) {
    //   carouselHeight =
    //       screenHeight * 0.25; // 32% of screen height for small devices
    // } else if (screenWidth < 600) {
    //   carouselHeight = screenHeight * 0.28; // 35% for medium devices
    // } else {
    //   carouselHeight = screenHeight * 0.32; // 38% for larger devices
    // }

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
    final isBrand = context.select((CategoryCubit c) => c.isBrand);
    return Scaffold(
      appBar: _buildAppBar(isBrand),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBannerSection(),
            _buildBrandMallToggle(isBrand),
            _buildBannerSection(),
            _buildCategoriesSection(),
            _buildBestSellers(isBrand),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isBrand) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return AppBar(
      toolbarHeight: 80,
      iconTheme: IconThemeData(color: AppColors.deepBlue),
      leadingWidth: isSmallScreen ? 60 : 80,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: Image.asset(
          isBrand
              ? Assets.iconsW2DLogoAspirationalGold
              : Assets.iconsW2DLogoGreen,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: isSmallScreen ? 8 : 16),
          child: BrandMallToggleWidget(
            onTap: () {
              context.read<CategoryCubit>().toggleBrand();
            },
            isBrand: isBrand,
          ),
        ),
      ],
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

  Widget _buildBrandMallToggle(bool isBrand) {
    return GestureDetector(
      onTap: () {
        context.read<CategoryCubit>().toggleBrand();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: HomeScreenBrandToggle(
                isBrand: !isBrand,
                image:
                    isBrand
                        ? Assets.iconsHiddenGemsActive
                        : Assets.iconsHiddenGemsInactive,
                text: "Hidden Gems",
                gradient: AppColors.worldGreenGradiant,
                borderColor: AppColors.worldGreen80,
              ),
            ),
            Flexible(
              child: HomeScreenBrandToggle(
                isBrand: isBrand,
                image:
                    isBrand
                        ? Assets.iconsBrandMallInactive
                        : Assets.iconsBrandMallActive,
                text: "Brand Mall",
                gradient: AppColors.aspirationGold,
                borderColor: AppColors.doorOchre,
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildBestSellers(bool isBrand) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        if (state is CollectionsLoaded) {
          brandMallCollections.clear();
          hiddenGemsCollections.clear();
          brandMallCollections = state.brandMallCollections;
          hiddenGemsCollections = state.hiddenGemsCollections;
        }
      },
      builder: (context, state) {
        final collections =
            isBrand ? brandMallCollections : hiddenGemsCollections;

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
              return _buildCollectionSection(collections[index], isBrand);
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: collections.length,
          ),
        );
      },
    );
  }

  Widget _buildCollectionSection(
    CollectionsResultDataEntity collection,
    bool isBrand,
  ) {
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
}
