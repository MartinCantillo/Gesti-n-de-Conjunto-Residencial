import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/config/themes/app_themes.dart';

class FloatingNavBar extends ConsumerWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  SafeArea(
        child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButtonNavBar(const Icon(Icons.home)),
            IconButtonNavBar(const Icon(Icons.history)),
            IconButtonNavBar(const Icon(Icons.chat)),
            IconButtonNavBar(const Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

  IconButton IconButtonNavBar(Icon icon) {
    return IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: () {
              
            },
          );
  }
}
