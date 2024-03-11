import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Administrador.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Models/EstadoAnomalia.dart';
import 'package:gestionresidencial/Models/Residente.dart';
import 'package:gestionresidencial/Models/User.dart';
import 'package:gestionresidencial/Provider/AdministradorModelProvider.dart';
import 'package:gestionresidencial/Provider/AnomaliaProvider.dart';
import 'package:gestionresidencial/Provider/AuthenticatedUserdProvider.dart';
import 'package:gestionresidencial/Provider/EstadoAnomaliaProvider.dart';
import 'package:gestionresidencial/Provider/ResidenteProvider.dart';
import 'package:gestionresidencial/Provider/UserProvider.dart';

import 'package:gestionresidencial/Views/Widgets/hiddenDrawer/hiddenDrawer.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomeAdmin/HomeA.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';
import 'package:gestionresidencial/Views/screens/Login/form_register_screen.dart';

import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';
import 'package:gestionresidencial/Views/screens/Login/newloginPage.dart';
import 'package:gestionresidencial/Views/screens/Login/register_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';
import 'package:gestionresidencial/Views/screens/Report/detailsReport_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';

import 'package:gestionresidencial/config/themes/app_themes.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

Future<void> main() async {
  final prefs = PrefernciaUsuario();
  await prefs.initPrefs();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isDarkMode = false;
    final theme = ref.watch(themeProvider);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conjunto Residencial App',
      theme: getThemeData(theme),
      initialRoute: LoginPageNew.nombre,
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
        HomePage.nombre:(context) => const  HomePage(),
        LoginPageNew.nombre:(context) => const LoginPageNew(),
        DetalleReportes.nombre:(context) => DetalleReportes()
      },
    );
  }
}

//Providers

final administradorProvider =
    StateNotifierProvider<AdministradorProvider, List<AdministradorModel>>(
        (ref) {
  return AdministradorProvider([]);
});
final anomaliaProvider =
    StateNotifierProvider<AnomaliaProvider, List<AnomaliaModel>>((ref) {
  return AnomaliaProvider([]);
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
final userProvider =
    StateNotifierProvider<UserProvider, List<UserModel>>((ref) {
  return UserProvider([]);
});
final userAuthenticatedProviderr =
    StateNotifierProvider<AuthenticatedUserdProvider, List<UserModel>>((ref) {
  return AuthenticatedUserdProvider([]);
});
final themeProvider = StateProvider<AppTheme>((ref) {
  return AppTheme.Light;
});




final pkAdminProvider = StateProvider<String>((ref) => "");
final pkAnomaliaProvider = StateProvider<String>((ref) => "");
final pkEstadoAnomaliaProvider = StateProvider<String>((ref) => "");
final pkResidenteProvider = StateProvider<String>((ref) => "");
final pkUserProvider = StateProvider<String>((ref) => "");
