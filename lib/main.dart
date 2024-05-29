import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Banner.dart';
import 'package:gestionresidencial/Provider/BannerProvider.dart';
import 'package:gestionresidencial/Views/screens/Historial/historialbanner_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/BannerReport.dart';

import 'package:gestionresidencial/config/themes/app_themes.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

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

import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomeAdmin/HomeA.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';
import 'package:gestionresidencial/Views/screens/Login/form_register_screen.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';
import 'package:gestionresidencial/Views/screens/Login/register_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detailsReport_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';
import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';
import 'package:gestionresidencial/Views/screens/Notification/notification_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PrefernciaUsuario();
  await prefs.initPrefs();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
String _getInitialRoute() {
    final prefs = PrefernciaUsuario();
    final token = prefs.token; // Asume que tienes un getter para obtener el token
    if (token != null && token.isNotEmpty) {
      return HomePage.nombre;
    } else {
      return LoginPage.nombre;
    }
  }

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conjunto Residencial App',
      theme: getThemeData(theme),
      initialRoute: LoginPage.nombre,
      routes: {
        LoginPage.nombre: (context) => const LoginPage(),
        RegisterPage.nombre: (context) => const RegisterPage(),
        MyHomePage.nombre: (context) => const MyHomePage(),
        HistorialPage.nombre: (context) => const HistorialPage(),
        ChatPage.nombre: (context) => const ChatPage(),
        SettingsPage.nombre: (context) => const SettingsPage(),
        reporte.nombre: (context) => const reporte(),
        HomeAdmin.nombre: (context) => const HomeAdmin(),
        HomePage.nombre: (context) => const HomePage(),
        DetalleReportes.nombre: (context) {
          final AnomaliaModel anomalia =
              ModalRoute.of(context)!.settings.arguments as AnomaliaModel;
          return DetalleReportes(anomalia: anomalia);
        },
        FormRegisterPage.nombre: (context) => const FormRegisterPage(),
        ListAnomalias.nombre: (context) => const ListAnomalias(),
        NotificationPage.nombre: (context) => const NotificationPage(),
        BannerReport.nombre: (context) => const BannerReport(),
        BannerScreen.nombre: (context) => const BannerScreen()
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
final bannerProvider =
    StateNotifierProvider<BannerProvider, List<BannerModel>>((ref) {
  return BannerProvider([]);
});

final pkBannerProvider =StateProvider<String>((ref) => "");
final pkAdminProvider = StateProvider<String>((ref) => "");
final pkAnomaliaProvider = StateProvider<String>((ref) => "");
final pkEstadoAnomaliaProvider = StateProvider<String>((ref) => "");
final pkResidenteProvider = StateProvider<String>((ref) => "");
final pkUserProvider = StateProvider<String>((ref) => "");
final pkUserProvidersave = StateProvider<String>((ref) => "");
