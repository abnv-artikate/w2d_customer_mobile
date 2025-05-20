import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LocationWidget extends StatelessWidget {
  final String location;
  final VoidCallback onTap;

  const LocationWidget({
    super.key,
    required this.location,
    required this.onTap,
  });

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
              location,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
