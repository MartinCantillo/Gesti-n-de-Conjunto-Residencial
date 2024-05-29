import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Residente.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:gestionresidencial/main.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String nombre = 'settings';

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late Future<List<ResidenteModel>> residenteList = Future.value([]);
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    String token = await ref.read(anomaliaProvider.notifier).getToken();
    residenteList = ref.read(residenteProvider.notifier).getResidenteById(idUserGot, token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: ListView(
            children: [
              FutureBuilder<List<ResidenteModel>>(
                future: residenteList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final residente = snapshot.data!.first;
                    return UserAccountsDrawerHeader(
                      accountName: Text(residente.nombreResidente??""),
                      accountEmail: Text(prefs.usuario),
                    );
                  } else {
                    return const Text('No se encontró el residente');
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Cerrar sesión'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmación'),
                        content: const Text('¿Seguro que quiere cerrar sesión?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Aquí se usa Navigator.pushAndRemoveUntil para eliminar todas las rutas anteriores
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('Sí'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
