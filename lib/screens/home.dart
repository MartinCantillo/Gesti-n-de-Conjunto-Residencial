import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  static const String nombre = 'home';
  
  @override
  State<HomePage> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<HomePage> {
   //final prefs = PreferenciaUsuario();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'Historial',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            if (index == 0) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Home'),
                  leading: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text('Menú'),
                            actions: [
                              CupertinoActionSheetAction(
                                child: Text('Perfil'),
                                onPressed: () {
                                  // Manejar la acción de la opción 1
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Configuracion'),
                                onPressed: () {
                                  // Manejar la acción de la opción 2
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text('Cerrar sesion'),
                                onPressed: () {
                                  // Manejar la acción de la opción 2
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 30,
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Container(
                            width: 30,
                            height: 2,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4),
                          Container(
                            width: 30,
                            height: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: Center(
                  child: Text('Home'),
                ),
              );
            } else if (index == 1) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Chats'),
                ),
                child: Center(
                  child: Text("Chat"),
                ),
              );
            } else if (index == 2) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Historial'),
                ),
                child: Center(
                  child: Text("historial"),
                ),
              );
            }
            return Center(
              child: Text('Pestaña no reconocida'),
            );
          },
        );
      },
    );
  }
}
