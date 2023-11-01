import 'package:flutter/material.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:gestionresidencial/screens/home.dart';
import 'package:gestionresidencial/screens/login.dart';

Future<void> main() async {
  final prefs = PrefernciaUsuario();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      initialRoute: LoginPage.nombre,
      routes: {
        LoginPage.nombre:(context) => LoginPage(),
        HomePage.nombre:(context) => HomePage(),
      },
    );
  }
}

