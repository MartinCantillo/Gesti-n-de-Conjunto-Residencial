import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Widgets/WidgetsAdmin/AdminWidget.dart';



class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({super.key});

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.chat_bubble_rounded)),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.account_circle_rounded),
            ),
            label: 'Configuracion',
          ),
        ],
      ),
      body: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.star_rate),
                  trailing: Icon(Icons.add_chart),
                  title: Text('falla eléctrica'),
                  subtitle: Text('Falla electrica en el apartamento #4 '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star_rate),
                  trailing: Icon(Icons.add_chart),
                  title: Text('fuga de agua'),
                  subtitle: Text('Teno una anomalia en mi departamento '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star_rate),
                  trailing: Icon(Icons.add_chart),
                  title: Text('ascensor averiado'),
                  subtitle: Text('Cuando me vienen a arreglar eso  '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star_border_outlined),
                  trailing: Icon(Icons.add_chart),
                  title: Text('Fuga de gas'),
                  subtitle: Text('Fuga de gas en la cocina '),
                ),
              ),
            ],
          ),
        ),

        // Resto de las páginas
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.messenger_rounded),
                  //    trailing: Icon(Icons.add_chart),
                  title: Text('Martin Cantillo'),
                  subtitle: Text('Todo bien que '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.messenger_rounded),
                  //   trailing: Icon(Icons.add_chart),
                  title: Text('Jorge Araujo'),
                  subtitle: Text('Teno una anomalia en mi departamento '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.messenger_rounded),
                  //  trailing: Icon(Icons.add_chart),
                  title: Text('Omar'),
                  subtitle: Text('Cuando me vienen a arreglar eso  '),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.messenger_rounded),
                  //   trailing: Icon(Icons.add_chart),
                  title: Text('Delka'),
                  subtitle: Text('Puro kuervo en la via   '),
                ),
              ),
            ],
          ),
        ),
       AdminW()
      ][currentPageIndex],
    );
  }
}
