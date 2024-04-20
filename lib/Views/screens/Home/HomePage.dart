import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/Widgets/home/AppBar/buildCustomAppBar.dart';
import 'package:gestionresidencial/Views/Widgets/home/Body/bodyHome.dart';
import 'package:gestionresidencial/Views/Widgets/home/NavBar/floatingNavBar.dart';

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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Bloquea la navegación hacia atrás
          return false;
        },
        child: Scaffold(
          appBar: null,
          body: const Stack(
            children: [
              BodyHome(),
              BuildCustomAppBar(),
            ],
          ),
          bottomNavigationBar: const FloatingNavBar(),
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
