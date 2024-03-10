import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Components/mybutton2_component.dart';

import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String nombre = 'myHomePage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // Puedes ajustar el color según tu preferencia
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hola, Bienvenido',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          const Text(
                            'Mis reportes',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Spacer(),
                          MyButton2(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, HistorialPage.nombre);
                              setState(() {});
                            },
                            title: 'Ver todos',
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: appState.reports.isEmpty
                            ? const Center(
                                child: Text('No hay reportes'),
                              )
                            : const Center(
                                child: Text('No hay reportes'),
                              )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, reporte.nombre);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*ListView _listReports() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsetsDirectional.all(8),
          margin: const EdgeInsetsDirectional.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(2, 4),
              ),
            ],
            color: Colors.grey[100],
          ),
          child: ListTile(
            title: Text('Tipo: ${appState.reports[index].type}'),
            subtitle: Text('Asunto: ${appState.reports[index].subject}'),
            trailing: const Column(
              children: [
                Text('Estado: En espera',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }*/
}
