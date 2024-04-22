import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String nombre = 'settings';

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final prefs = PrefernciaUsuario();

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
              UserAccountsDrawerHeader(
                accountName: Text(prefs.nombreusuario),
                accountEmail: Text(prefs.usuario),
              ),
              
              ListTile(
                title: const Text('Cambiar nombre de usuario'),
                onTap: () {
                  // Lógica para cambiar el nombre de usuario
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Cambiar número de teléfono'),
                onTap: () {
                  // Lógica para cambiar el número de teléfono
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Cambiar correo electrónico'),
                onTap: () {
                  // Lógica para cambiar el correo electrónico
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
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, LoginPage.nombre),
                            child: const Text('Si'),
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
