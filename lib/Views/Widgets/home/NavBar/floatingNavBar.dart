import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

class FloatingNavBar extends ConsumerStatefulWidget {
  const FloatingNavBar({super.key});

  @override
  FloatingNavBarState createState() => FloatingNavBarState();
}

class FloatingNavBarState extends ConsumerState<FloatingNavBar> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconButtonNavBar(
              context,
              Icon(Icons.home,
                  color: _selectedIndex == 0
                      ? Theme.of(context).primaryColor
                      : null),
                  () => Navigator.of(context).pushNamed(HomePage.nombre),
            ),
            iconButtonNavBar(
                context,
                Icon(Icons.history,
                    color: _selectedIndex == 1
                        ? Theme.of(context).primaryColor
                        : null),
                () => Navigator.of(context).pushNamed(HistorialPage.nombre)),
            iconButtonNavBar(
                context,
                Icon(Icons.chat,
                    color: _selectedIndex == 2
                        ? Theme.of(context).primaryColor
                        : null),
                () => Navigator.of(context).pushNamed(ChatPage.nombre)),
            iconButtonNavBar(
                context,
                Icon(Icons.person,
                    color: _selectedIndex == 3
                        ? Theme.of(context).primaryColor
                        : null),
                () => Navigator.of(context).pushNamed(settingsPage.nombre)),
          ],
        ),
      ),
    );
  }

  Widget iconButtonNavBar(
      BuildContext context, Icon icon, VoidCallback onPressed) {
    return IconButton(
      icon: icon,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed ?? () {},
    );
  }
}
