import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/category/category_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
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
  String? address;
  List<CollectionsResultDataEntity> brandMallCollections = [];
  List<CollectionsResultDataEntity> hiddenGemsCollections = [];
  List<SubCategoriesEntity> categoryList = [];

  @override
  void initState() {
    _callGetCollectionsApi();
    _callCategoriesListingAPi();
    super.initState();
  }

  // Dynamic carousel options based on screen size
  CarouselOptions get _bannerCarouselOptions {
    final screenWidth = MediaQuery.of(context).size.width;
    return CarouselOptions(
      disableCenter: true,
      height: screenWidth < 400 ? 160 : 200,
      // Responsive height
      viewportFraction: 1,
      initialPage: 0,
      autoPlay: true,
      autoPlayCurve: Curves.easeInOut,
      autoPlayAnimationDuration: Duration(milliseconds: 800),
    );
  }

  CarouselOptions get _categoriesCarouselOption {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic height calculation based on screen size
    double carouselHeight;
    if (screenWidth < 400) {
      carouselHeight =
          screenHeight * 0.25; // 32% of screen height for small devices
    } else if (screenWidth < 600) {
      carouselHeight = screenHeight * 0.28; // 35% for medium devices
    } else {
      carouselHeight = screenHeight * 0.32; // 38% for larger devices
    }

    return CarouselOptions(
      disableCenter: true,
      padEnds: false,
      height: carouselHeight,
      viewportFraction: screenWidth < 400 ? 0.55 : 0.5,
      // More items visible on small screens
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
      // Responsive app bar height
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
      // bottom: PreferredSize(
      //   preferredSize: Size.zero,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
      //     child: SearchWidget(
      //       onTap: () {
      //         context.push(AppRoutes.searchRoute);
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildBannerSection() {
    return Column(
      children: [
        SizedBox(height: 10),
        CarouselSlider(
          options: _bannerCarouselOptions,
          items:
              imgList.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Image not available',
                              style: TextStyle(color: AppColors.black70),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBrandMallToggle(bool isBrand) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeScreenBrandToggle(
            isBrand: !isBrand,
            image:
                isBrand
                    ? Assets.iconsHiddenGemsActive
                    : Assets.iconsHiddenGemsInactive,
            text: "Hidden Gems",
            gradient: AppColors.worldGreenGradiant,
            borderColor: AppColors.worldGreen80,
          ),
          HomeScreenBrandToggle(
            isBrand: isBrand,
            image:
                isBrand
                    ? Assets.iconsBrandMallInactive
                    : Assets.iconsBrandMallActive,
            text: "Brand Mall",
            gradient: AppColors.aspirationGold,
            borderColor: AppColors.doorOchre,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 400 ? 8.0 : 16.0;

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
                    .map((e) => CategoryBubble(category: e))
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

    // Calculate dynamic item width for carousel
    final carouselItemWidth =
        (screenWidth * (screenWidth < 400 ? 0.55 : 0.5)) -
        (horizontalPadding * 2);

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
                  width: carouselItemWidth,
                  isGridView: false,
                  // This is carousel context
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

  void _callGetCollectionsApi() async {
    await context.read<CommonCubit>().getCollections();
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
