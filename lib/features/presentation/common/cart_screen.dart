import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isChecked = true;
  int count = 45;
  final String img =
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), centerTitle: true),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Stack(
            children: [
              _cartItem(),
              Positioned(
                left: 30,
                top: 20,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: _checkBox(isChecked),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {},
        backgroundColor: AppColors.worldGreen,
        child: Text('Checkout', style: TextStyle(fontSize: 18),),
      ),
    );
  }

  Widget _cartItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black70),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Image.network(img, width: 80, height: 60, fit: BoxFit.contain),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sofas 3 + 2 + 1 Sofa Set (Grey, DIY(Do-It-Yourself)',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text('₹35,999', style: TextStyle(fontSize: 25)),
                    Text('In stock', style: TextStyle(fontSize: 20)),
                    Text('In stock', style: TextStyle(fontSize: 20)),
                    Text('In stock', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 100,
            right: 10,
            child: _incrementWidget(
              number: count,
              onPlusTap: () {
                setState(() {
                  count += 1;
                });
              },
              onMinusTap: () {
                setState(() {
                  count -= 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBox(bool isChecked) {
    return isChecked
        ? Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.black70),
            color: AppColors.black,
          ),
          child: Icon(LucideIcons.check, size: 30, color: AppColors.white),
        )
        : Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.black70),
          ),
        );
  }

  Widget _incrementWidget({
    required int number,
    VoidCallback? onPlusTap,
    VoidCallback? onMinusTap,
  }) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.worldGreen),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                LucideIcons.plus,
                color: AppColors.worldGreen,
                size: 20,
              ),
              onPressed: onPlusTap,
            ),
          ),
          Text(
            '$number',
            style: TextStyle(fontSize: 25, color: AppColors.worldGreen),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                LucideIcons.minus,
                color: AppColors.worldGreen,
                size: 20,
              ),
              onPressed: onMinusTap,
            ),
          ),
        ],
      ),
    );
  }
}
