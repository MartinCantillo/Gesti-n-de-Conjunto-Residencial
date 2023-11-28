import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/WidgetsAdmin/NavbarAdmin.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});
  
  static const String nombre = 'HomeAdmin';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
       debugShowCheckedModeBanner: false,
      home: const NavbarAdmin(),
    );
  }
}
