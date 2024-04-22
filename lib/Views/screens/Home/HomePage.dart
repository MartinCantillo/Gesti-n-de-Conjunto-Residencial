import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/Widgets/home/AppBar/buildCustomAppBar.dart';
import 'package:gestionresidencial/Views/Widgets/home/Body/bodyHome.dart';
import 'package:gestionresidencial/Views/Widgets/home/NavBar/floatingNavBar.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';

import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static String nombre = 'homepage';

  @override
  HomePageState createState() => HomePageState();
}

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Bloquea la navegación hacia atrás
          return false;
        },
        child: Scaffold(
          appBar: null,
          body: IndexedStack(
            index: _selectedIndex,
            children: const [
              Stack(
                children: [
                  BodyHome(),
                  BuildCustomAppBar(),
                ],
              ),
              HistorialPage(),
              ChatPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: FloatingNavBar(),
          floatingActionButton: addButton(context),
        ),
      ),
    );
  }
}

Widget addButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.pushNamed(context, reporte.nombre);
    },
    tooltip: 'Agregar',
    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
    elevation: 0,
    child: Icon(
      Icons.add_rounded,
      color: Theme.of(context).primaryColor,
    ),
  );
}
