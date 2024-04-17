import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        leading: IconButton(onPressed: () => Navigator.pop(context), icon:  Icon(Icons.arrow_back_rounded, color: Theme.of(context).secondaryHeaderColor,)),
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
