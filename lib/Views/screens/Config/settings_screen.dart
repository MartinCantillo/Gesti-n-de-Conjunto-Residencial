import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

// ignore: camel_case_types
class settingsPage extends ConsumerStatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  static const String nombre = 'settings';

  @override
  ConsumerState<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends ConsumerState<settingsPage> {
  final prefs = PrefernciaUsuario();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), 
        icon:  Icon(Icons.arrow_back_rounded, 
        color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmación'),
                  content:
                      const Text('¿Quieres cerrar la sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, LoginPage.nombre), child: Text('Si'),
                    ),
                  ],
                );
              },
            );
            
          }, icon: Icon(
            Icons.logout,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          ),
        ],
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
            children:  [
              UserAccountsDrawerHeader(
                accountName: Text(prefs.nombreusuario),
                accountEmail: Text(prefs.usuario),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 68.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
