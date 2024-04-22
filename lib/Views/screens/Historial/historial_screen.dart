import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Views/Widgets/home/NavBar/floatingNavBar.dart';

import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

import 'package:gestionresidencial/main.dart';

class Estadoanomaliacolor {
  static final Map<String, Color> estadoColor = {
    'Pendiente': Colors.orange,
    'Proceso': Colors.blue,
    'Completado': Colors.green,
    'Rechazado': Colors.red,
  };
}

class HistorialPage extends ConsumerStatefulWidget {
  static const String nombre = 'historialPage';
  const HistorialPage({Key? key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends ConsumerState<HistorialPage> {
  late Future<List<AnomaliaModel>> anomaliasList;
  final Map<String, String> _tipoAnomaliaImagenes = {
    'Infraestructura':
        'https://cdn-icons-png.flaticon.com/512/9147/9147877.png',
    'Seguridad': 'https://cdn-icons-png.flaticon.com/512/8631/8631499.png',
    'Incidente Médico':
        'https://media.istockphoto.com/id/1321617070/es/vector/logotipo-m%C3%A9dico-de-salud.jpg?s=612x612&w=0&k=20&c=BsQIM8iPSDMgR8eQZNOjpd0Q2JuuhyM9dMOC7fFgHC4=',
    'Servicios Públicos':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2rvBncx8szJO-kyRfk7t6Pgxfx5YKrPzVHisfCG-DIhbsbOQ4XBlfyJ4p09hYS8pOECo&usqp=CAU',
    'Otro':
        'https://static.vecteezy.com/system/resources/thumbnails/007/126/739/small/question-mark-icon-free-vector.jpg'
  };

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
    int _selectedIndex = 1;
    // Obtenemos los datos de anomalías del provider
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<AnomaliaModel>>(
          future: anomaliasList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay reportes'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final report = snapshot.data![index];
                  final reportId = report.id;
                  final tipoAnomalia = report.tipoAnomalia;
                  final imagenUrl = _tipoAnomaliaImagenes[tipoAnomalia];
                  return Dismissible(
                    key: Key(reportId ?? ''),
                    direction: DismissDirection.endToStart,
                    background: Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 150),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        if (reportId != null && reportId.isNotEmpty) {
                          _deleteAnomalia(reportId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Anomalia eliminada"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          print(reportId);
                          print("ERROR al intentar eliminar la anomalia");
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
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
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text('${report.tipoAnomalia}'),
                        subtitle: Text('${report.asuntoAnomalia}'),
                        trailing: Column(
                          children: [
                            Text(
                              '${report.idEstadoAnomalia}',
                              style: TextStyle(
                                  color: Estadoanomaliacolor
                                      .estadoColor[report.idEstadoAnomalia],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage: imagenUrl != null
                              ? NetworkImage(imagenUrl)
                              : null,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            DetalleReportes.nombre,
                            arguments: report,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: FloatingNavBar(),
    );
  }
}
