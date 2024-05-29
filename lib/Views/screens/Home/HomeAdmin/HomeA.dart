import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Provider/todoProvider/todoProvider.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/BannerReport.dart';
import 'package:gestionresidencial/main.dart';

class HomeAdmin extends ConsumerStatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  static const String nombre = 'HomeAdmin';

  @override
  ConsumerState<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends ConsumerState<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reportes'),
      ),
      body: const _ReportListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacementNamed(context, BannerReport.nombre);
        },
      ),
    );
  }
}

class _ReportListView extends ConsumerStatefulWidget {
  const _ReportListView();

  @override
  ConsumerState<_ReportListView> createState() => _ReportListViewState();
}

class _ReportListViewState extends ConsumerState<_ReportListView> {
  late Future<List<AnomaliaModel>> anomaliasList = Future.value([]);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String token = await ref.read(anomaliaProvider.notifier).getToken();
      setState(() {
        anomaliasList = ref.read(anomaliaProvider.notifier).getAll(token);
      });
    } catch (e) {
      print("Error fetchData: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFilter = ref.watch(todoFilterProvider);

    return Column(
      children: [
        const ListTile(
          title: Text('Listado de reportes'),
          subtitle: Text('Estos son los reportes hechos por los residentes'),
        ),
        SegmentedButton(
          segments: const [
            ButtonSegment(
                value: TodoFilter.completed, icon: Text('Completados',style: TextStyle(fontSize: 12),)),
            ButtonSegment(value: TodoFilter.pending, icon: Text('Pendiente',style: TextStyle(fontSize: 12))),
            ButtonSegment(value: TodoFilter.process, icon: Text('Proceso',style: TextStyle(fontSize: 12))),
            ButtonSegment(value: TodoFilter.rejected, icon: Text('Rechazado',style: TextStyle(fontSize: 12))),
          ],
          selected: <TodoFilter>{currentFilter},
          onSelectionChanged: (value) {
            ref.read(todoFilterProvider.notifier).state = value.first;
          },
        ),
        const SizedBox(height: 5),

        /// Listado de reportes
        Expanded(
          child: FutureBuilder(
            future: anomaliasList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                print(snapshot.data.toString());
                List<AnomaliaModel>? filteredList =
                    snapshot.data?.where((anomalia) {
                      print(anomalia.toString());
                      print(anomalia.toMap());
                  switch (currentFilter) {
                    case TodoFilter.pending:
                      return anomalia.idEstadoAnomalia == "Pendiente";
                    case TodoFilter.rejected:
                      return anomalia.idEstadoAnomalia == "rechazado";
                    case TodoFilter.process:
                      return anomalia.idEstadoAnomalia == "Proceso";
                    case TodoFilter.completed:
                      return anomalia.idEstadoAnomalia == "Completado";

                    default:
                      return true;
                  }
                }).toList();

                if (filteredList != null) {
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final AnomaliaModel datosA = filteredList[index];

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildAnomaliaDialog(datosA),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(datosA.asuntoAnomalia ?? ""),
                            subtitle: Text(datosA.descripcionAnomalia ?? ""),
                            trailing: Text(datosA.fechaReporteAnomalia ?? ""),
                            // Botón para cambiar el estado de la anomalía
                            leading: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      _buildChangeStatusDialog(context, datosA),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnomaliaDialog(AnomaliaModel anomalia) {
  String? selectedPrioridad = anomalia.prioridad ?? '';

  return AlertDialog(
    title: Text(anomalia.asuntoAnomalia ?? ""),
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${anomalia.descripcionAnomalia}'),
            const SizedBox(height: 10),
            const Text('Prioridad:'),
            DropdownButton<String>(
              value: selectedPrioridad,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPrioridad = newValue;
                });
              },
              items: <String?>['', 'Baja', 'Media', 'Alta']
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value ?? '',
                  child: Text(value ?? 'Sin prioridad'),
                );
              }).toList(),
            ),
          ],
        );
      },
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Cerrar el diálogo
        },
        child: const Text('Cerrar'),
      ),
      ElevatedButton(
        onPressed: () async {
          if (selectedPrioridad != null) {
            // Actualiza el valor en la anomalía
            anomalia.prioridad = selectedPrioridad;
            // Actualiza la anomalía en el proveedor
            String token = await ref.read(anomaliaProvider.notifier).getToken();
            await ref
                .read(anomaliaProvider.notifier)
                .update(anomalia.id ?? "", anomalia, token);

            // Muestra un SnackBar con el mensaje de éxito
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Se ha actualizado la prioridad con éxito'),
                duration: Duration(seconds: 2), // Duración del SnackBar
              ),
            );
          }
          // Cierra el diálogo
          Navigator.of(context).pop();
        },
        child: const Text('Asignar Prioridad'),
      ),
    ],
  );
}


  Widget _buildChangeStatusDialog(BuildContext context, AnomaliaModel anomalia) {
  String? nuevoEstado = anomalia.idEstadoAnomalia;
  print(anomalia.id);

  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: Text('Cambiar Estado'),
        content: DropdownButton<String>(
          value: nuevoEstado,
          onChanged: (String? newValue) {
            setState(() {
            
              nuevoEstado = newValue?.toLowerCase();
              if (nuevoEstado != null && nuevoEstado!.isNotEmpty) {
                nuevoEstado = nuevoEstado![0].toUpperCase() + nuevoEstado!.substring(1);
              }
            });
          },
          items: <String?>['', 'Pendiente', 'Rechazado', 'Proceso', 'Completado']
              .map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value ?? ''),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nuevoEstado != null) {
                // Actualiza el estado de la anomalía en el proveedor
                anomalia.idEstadoAnomalia = nuevoEstado!;
                String token = await ref.read(anomaliaProvider.notifier).getToken();
                await ref
                    .read(anomaliaProvider.notifier)
                    .update(anomalia.id ?? "", anomalia, token);

               
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Se ha cambiado el estado con éxito'),
                    duration: Duration(seconds: 2), // Duración del SnackBar
                  ),
                );
              } else {
                // Si el nuevo estado es null, muestra un mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error: Debes seleccionar un estado válido'),
                    duration: Duration(seconds: 2), // Duración del SnackBar
                  ),
                );
              }
              // Cierra el diálogo
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}



}
