import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;

  const MyButton2({super.key, 
    required this.onTap, 
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
