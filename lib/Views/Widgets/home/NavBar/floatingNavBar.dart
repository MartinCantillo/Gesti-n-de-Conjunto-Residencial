import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

class FloatingNavBar extends ConsumerWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return  SafeArea(
        child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconButtonNavBar(context, 
              const Icon(Icons.home), 
              () => Navigator.pushNamed(context, HomePage.nombre),
            ),
            iconButtonNavBar(context, 
              const Icon(Icons.history),
              ()=>Navigator.pushNamed(context, HistorialPage.nombre),
            ),
            iconButtonNavBar(context,
              const Icon(Icons.chat),
              ()=>Navigator.pushNamed(context, ChatPage.nombre),
            ),
            iconButtonNavBar(context, 
              const Icon(Icons.person),
              ()=>Navigator.pushNamed(context, settingsPage.nombre)
            ),
          ],
        ),
      ),
    );
  }

  Widget iconButtonNavBar(BuildContext context, Icon icon,  VoidCallback onPressed) {
    return IconButton(
            icon: icon,
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
          );
  }
}
