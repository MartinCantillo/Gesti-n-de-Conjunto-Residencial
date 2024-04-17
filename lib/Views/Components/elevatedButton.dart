import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        child: title,
      ),
    );
  }
}