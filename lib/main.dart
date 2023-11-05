import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/drawer.dart';
import 'package:gestionresidencial/Views/screens/home.dart';
import 'package:gestionresidencial/Views/screens/login.dart';
import 'package:gestionresidencial/Views/screens/myHomePage.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';


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
        myHomePage.nombre:(context) => myHomePage(),
       CustomDrawer.nombre:(context) => CustomDrawer(),
        Home2.nombre:(context) => Home2(),
      },
    );
  }
  
}

