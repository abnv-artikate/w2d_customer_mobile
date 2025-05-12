import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final IconData icon;
  final String location;
  final VoidCallback onTap;

  const LocationWidget({
    super.key,
    required this.icon,
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
            Icon(icon),
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
