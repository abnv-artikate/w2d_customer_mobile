import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/categories_listing_widget.dart';

class ExploreCategoriesScreen extends StatelessWidget {
  const ExploreCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CategoriesListingWidget(
              onTap: () {
                context.push(AppRoutes.listingRoute);
              },
            );
          },
          itemCount: 25,
        ),
      ),
    );
  }
}
