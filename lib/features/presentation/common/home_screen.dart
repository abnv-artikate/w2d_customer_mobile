import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/brand_mall_toggle_widget.dart';
import 'package:w2d_customer_mobile/core/widgets/product_item_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/location_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/search_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
];

final List<Widget> imageSliders =
    imgList
        .map(
          (item) => Image.network(
            item,
            fit: BoxFit.cover,
            height: 200,
            errorBuilder: (context, widget, stack) {
              return Center(child: Text('Image not available.'));
            },
          ),
        )
        .toList();

class HomeScreen extends StatefulWidget {
  // final UserEntity userEntity;

  const HomeScreen({super.key /*required this.userEntity*/});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselOptions _brandMallCarouselOptions = CarouselOptions(
    disableCenter: true,
    height: 200,
    viewportFraction: 1,
    initialPage: 2,
    autoPlay: true,
    autoPlayCurve: Curves.linear,
  );

  final CarouselOptions _bestSellerCarouselOption = CarouselOptions(
    disableCenter: true,
    padEnds: false,
    height: 270,
    viewportFraction: 0.5,
    enableInfiniteScroll: false,
  );

  int navBarIndex = 0;
  bool isBrand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        // backgroundColor: AppColors.worldGreen10,
        // title: Image.asset(
        //   Assets.iconsW2DHorizontalLogo,
        //   fit: BoxFit.fitHeight,
        //   color: AppColors.deepBlue,
        // ),
        // centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.deepBlue),
        leadingWidth: 80,
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
          // BrandMallToggleWidget(
          //   onTap: () {
          //     setState(() {
          //       isBrand = !isBrand;
          //     });
          //   },
          //   isBrand: isBrand,
          // ),
          // LocationWidget(),
        ],
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Row(
            children: [
              SearchWidget(
                onTap: () {
                  context.push(AppRoutes.searchRoute);
                },
              ),
              Expanded(
                child: BrandMallToggleWidget(
                  onTap: () {
                    setState(() {
                      isBrand = !isBrand;
                    });
                  },
                  isBrand: isBrand,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _brandAndHiddenGems(),
            _bestSellers(),
            _popularCategories(),
          ],
        ),
      ),
    );
  }

  Widget _brandAndHiddenGems() {
    return Column(
      children: [
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: CarouselSlider(
            options: _brandMallCarouselOptions,
            items: imageSliders,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _bestSellers() {
    return Container(
      color: AppColors.softWhite71,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BEST SELLERS',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          CarouselSlider(
            options: _bestSellerCarouselOption,
            items: List.generate(5, (_) {
              return Container(
                color: AppColors.transparent,
                child: ProductItemWidget(
                  width: MediaQuery.of(context).size.width * 0.45, imgUrl: '', itemName: '', salePrice: '', regularPrice: '',
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  _popularCategories() {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(child: Text('//TODO: Popular categories here')),
      ],
    );
  }
}
