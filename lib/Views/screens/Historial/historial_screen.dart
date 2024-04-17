import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';

import 'package:gestionresidencial/Views/screens/Report/detailsReport_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';

import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

import 'package:gestionresidencial/main.dart';

class HistorialPage extends ConsumerStatefulWidget {
  static const String nombre = 'historialPage';
  const HistorialPage({Key? key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends ConsumerState<HistorialPage> {
  late Future<List<AnomaliaModel>> anomaliasList;

  @override
  void initState() {
    super.initState();
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    anomaliasList =
        ref.read(anomaliaProvider.notifier).getAnomaliaById(idUserGot);
  }

  Future<void> _deleteAnomalia(String id) async {
    if (id != null && id.isNotEmpty) {
      try {
        await ref.read(anomaliaProvider.notifier).delete(id);
        print("Se ha eliminado la anomalia");
      } catch (e) {
        print(e);
      }
    } else {
      print("el id esta vacio");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos los datos de anomalías del provider

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(HomePage.nombre);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: FutureBuilder<List<AnomaliaModel>>(
        future: anomaliasList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay reportes'));
          } else {
            return _ListReports(snapshot.data ?? []);
          }
        },
      ),
    );
  }

  ListView _ListReports(List<AnomaliaModel> reports) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        final reportId = report.id;
        return Dismissible(
          key: Key(reportId ?? ''),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            if (direction == DismissDirection.endToStart) {
              if (reportId != null && reportId.isNotEmpty) {
                _deleteAnomalia(reportId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Anomalia eliminada"),
                  duration: Duration(seconds: 2),
                ));
              } else {
                print("ERROR al intentar eliminar la anomalia");
              }
            }
          },
          child: Container(
            padding: const EdgeInsetsDirectional.all(8),
            margin: const EdgeInsetsDirectional.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
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
              title: Text('${report.tipoAnomalia}'),
              subtitle: Text('${report.asuntoAnomalia}'),
              trailing: const Column(
                children: [
                  Text(
                    'Estado: Pendiente',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed(ListAnomalias
                    .nombre); // Asegúrate de que 'ReportScreen.nombre' sea el nombre correcto de la ruta
              },
            ),
          ),
        );
      },
    );
  }
}
