import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/drawer_widget.dart';
import 'package:gestionresidencial/Views/screens/chatPage_screen.dart';
import 'package:gestionresidencial/Views/screens/historialPage_screen.dart';
import 'package:gestionresidencial/Views/screens/loginPage_screen.dart';
import 'package:gestionresidencial/Views/screens/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/registerPage_screen.dart';
import 'package:gestionresidencial/config/themes/app_themes.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';


Future<void> main() async {
  final prefs = PrefernciaUsuario();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conjunto Residencial App',
      theme: AppTheme(selectedColor: 1).theme(),
      initialRoute: LoginPage.nombre,
      routes: {
        LoginPage.nombre:(context) => LoginPage(),
        Register.nombre:(context) => const Register(),
        myHomePage.nombre:(context) => const myHomePage(),
        CustomDrawer.nombre:(context) => const CustomDrawer(),
        Historial.nombre:(context) => const Historial(),
        chatPage.nombre:(context) => const chatPage()
      },
    );
  }
  
}

