import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';

class LocationWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String address;

  const LocationWidget({super.key, required this.onTap, required this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.mapPin),
            SizedBox(width: 5),
            Text(
              address,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
