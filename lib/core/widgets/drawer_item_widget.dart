import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;

  const DrawerItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
    );
  }
}
