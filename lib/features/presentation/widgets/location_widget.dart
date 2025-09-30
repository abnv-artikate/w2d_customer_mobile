import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LocationWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? address;

  const LocationWidget({super.key, required this.onTap, required this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.mapPin),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                address ?? "Tap to set Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
