import 'package:flutter/material.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/categories_hierarchy_entity.dart';

class CategoryBubble extends StatelessWidget {
  final SubCategoriesEntity category;

  final double? diameter;

  final double widthFraction;

  final double minDiameter;
  final double maxDiameter;

  final VoidCallback? onTap;

  const CategoryBubble({
    super.key,
    required this.category,
    this.diameter,
    this.widthFraction = 0.22,
    this.minDiameter = 64,
    this.maxDiameter = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        // Prefer parent constraints (great inside GridView), else fall back to screen size.
        double basis;
        if (constraints.hasBoundedWidth || constraints.hasBoundedHeight) {
          basis = constraints.biggest.shortestSide;
          if (basis.isInfinite || basis == 0) {
            final size = MediaQuery.sizeOf(context);
            basis = size.shortestSide;
          }
        } else {
          final size = MediaQuery.sizeOf(context);
          basis = size.shortestSide;
        }

        final d =
            (diameter ?? (basis * widthFraction))
                .clamp(minDiameter, maxDiameter)
                .toDouble();

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: SizedBox(
            width: d,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: d,
                  height: d,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.softWhite71,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.softWhite80,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipOval(
                      child: Image.network(
                        category.image,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image,
                          size: 28,
                          color: Colors.grey.shade500,
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}