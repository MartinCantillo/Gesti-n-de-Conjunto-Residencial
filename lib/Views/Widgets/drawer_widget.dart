import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Widgets/listTileDrawer_widget.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';
import 'package:gestionresidencial/Views/screens/Config/settings_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  static const String nombre = 'drawer';

  @override
  State<CustomDrawer> createState() => _DrawerState();
}

class _DrawerState extends State<CustomDrawer> {
  bool _colorsecundario = false;
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    _colorsecundario = prefs.colosecundario;
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Usuario'),
              accountEmail: Text('usuario@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 68.0,
                  color: Colors.black,
                ),
              ),
            ),
            ListTileDrawer(
              prefs: prefs,
              title: 'Home',
              icon: Icons.home,
              onTap: () {
                Navigator.of(context).popAndPushNamed(MyHomePage.nombre);
              },
            ),
            ListTileDrawer(
              prefs: prefs,
              title: 'Historial',
              icon: Icons.history,
              onTap: () {
                Navigator.of(context).popAndPushNamed(HistorialPage.nombre);
              },
            ),
            ListTileDrawer(
              prefs: prefs,
              title: 'Chat',
              icon: Icons.chat,
              onTap: () {
                Navigator.of(context).popAndPushNamed(ChatPage.nombre);
                //haz la ruta para entrar en la pagina del chat
              },
            ),

            const Divider(),

            SwitchListTile(
                value: _colorsecundario,
                title: const Text('Tema oscuro'),
                onChanged: (value) {
                  setState(() {
                    _colorsecundario = value;
                    prefs.colosecundario = value;
                  });
                }),
            ListTileDrawer(
              prefs: prefs,
              title: 'Configuración',
              icon: Icons.settings,
              onTap: () {
                Navigator.of(context).popAndPushNamed(settingsPage.nombre);
              },
            ),
          ],
        ),
      ),
    );
  }
}

