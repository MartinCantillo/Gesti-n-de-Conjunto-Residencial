import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Widgets/drawer_widget.dart';
import 'package:gestionresidencial/Views/screens/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/login_screen.dart';
import 'package:gestionresidencial/Views/screens/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/register_screen.dart';
import 'package:gestionresidencial/Views/screens/settings_screen.dart';

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
        RegisterPage.nombre:(context) => const RegisterPage(),
        MyHomePage.nombre:(context) => const MyHomePage(),
        CustomDrawer.nombre:(context) => const CustomDrawer(),
        HistorialPage.nombre:(context) => const HistorialPage(),
        ChatPage.nombre:(context) => const ChatPage(),
        settingsPage.nombre:(context) => const settingsPage()
      },
    );
  }
  
}

