import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/core/widgets/custom_filled_button_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final String img =
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: AppColors.transparent,
        leading: _backButton(),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.white,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark_border_outlined, size: 30),
              // Image.asset(
              //   Assets.iconsLikeOutlined,
              //   color: AppColors.black,
              //   height: 30,
              //   width: 30,
              // ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              img,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chair',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
              ),
              Text(
                '\u{20B9} 3500',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomFilledButtonWidget(
                title: 'Proceed to buy',
                color: AppColors.worldGreen,
                height: 60,
                width: MediaQuery.of(context).size.width * 0.48,
                onTap: () {},
              ),
              CustomFilledButtonWidget(
                title: 'Add to Cart',
                color: AppColors.deepBlue,
                height: 60,
                width: MediaQuery.of(context).size.width * 0.48,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  _backButton() {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white,
        ),
        child: Center(child: Icon(Icons.chevron_left, size: 30)),
      ),
    );
  }
}
