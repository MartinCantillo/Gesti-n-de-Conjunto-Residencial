import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Administrador.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Models/EstadoAnomalia.dart';
import 'package:gestionresidencial/Models/Residente.dart';
import 'package:gestionresidencial/Provider/AdministradorModelProvider.dart';
import 'package:gestionresidencial/Provider/AnomaliaProvider.dart';
import 'package:gestionresidencial/Provider/EstadoAnomaliaProvider.dart';
import 'package:gestionresidencial/Provider/ResidenteProvider.dart';

import 'package:gestionresidencial/Views/Widgets/hiddenDrawer/hiddenDrawer.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomeAdmin/HomeA.dart';

import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';
import 'package:gestionresidencial/Views/screens/Login/register_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';

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
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Conjunto Residencial App',
        theme: AppTheme(selectedColor: 1).theme(),
        initialRoute: LoginPage.nombre,
        routes: {
          LoginPage.nombre: (context) => LoginPage(),
          RegisterPage.nombre: (context) => const RegisterPage(),
          MyHomePage.nombre: (context) => const MyHomePage(),
          HistorialPage.nombre: (context) => const HistorialPage(reports: []),
          ChatPage.nombre: (context) => const ChatPage(),
          settingsPage.nombre: (context) => const settingsPage(),
          reporte.nombre: (context) => const reporte(),
          HomeAdmin.nombre: (context) => const HomeAdmin(),
          HiddenDrawer.nombre: (context) => const HiddenDrawer(),
        },
      ),
    );
  }
}

//Providers

final administradorProvider =
    StateNotifierProvider<AnomaliaProvider, List<AdministradorModel>>((ref) {
  return AnomaliaProvider([]);
});
final anomaliaProvider =
    StateNotifierProvider<AdministradorProvider, List<AnomaliaModel>>((ref) {
  return AdministradorProvider([]);
});
final estadoAnomaliaProvider =
    StateNotifierProvider<EstadoAnomaliaProvider, List<EstadoAnomaliaModel>>(
        (ref) {
  return EstadoAnomaliaProvider([]);
});
final residenteProvider =
    StateNotifierProvider<ResidenteProvider, List<ResidenteModel>>((ref) {
  return ResidenteProvider([]);
});

final pkAdminProvider = StateProvider<String>((ref) => "");
final pkAnomaliaProvider = StateProvider<String>((ref) => "");
final pkEstadoAnomaliaProvider = StateProvider<String>((ref) => "");
final pkResidenteProvider = StateProvider<String>((ref) => "");
