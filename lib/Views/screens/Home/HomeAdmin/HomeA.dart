import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Provider/todoProvider/todoProvider.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
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
        child: const Icon(Icons.message),
        onPressed: () {
          Navigator.pushNamed(context, ChatPage.nombre);
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
  late Future<List<AnomaliaModel>> anomaliasList;

  @override
  void initState() {
    anomaliasList = ref.read(anomaliaProvider.notifier).getAll();
    super.initState();
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
            ButtonSegment(value: TodoFilter.all, icon: Text('Todos')),
            ButtonSegment(
                value: TodoFilter.completed, icon: Text('Completados')),
            ButtonSegment(value: TodoFilter.pending, icon: Text('Pendientes')),
            ButtonSegment(value: TodoFilter.process, icon: Text('Proceso')),
            ButtonSegment(value: TodoFilter.rejected, icon: Text('Rechazado')),
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
                List<AnomaliaModel>? filteredList =
                    snapshot.data?.where((anomalia) {
                  switch (currentFilter) {
                    case TodoFilter.pending:
                      return anomalia.idEstadoAnomalia == 'pendiente';
                    case TodoFilter.rejected:
                      return anomalia.idEstadoAnomalia == 'rechazado';
                    case TodoFilter.process:
                      return anomalia.idEstadoAnomalia == 'proceso';
                    case TodoFilter
                          .completed: 
                      return anomalia.idEstadoAnomalia == 'completado';

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
    String? selectedPrioridad = anomalia.prioridad;

    return AlertDialog(
      title: Text(anomalia.asuntoAnomalia ?? ""),
      content: Column(
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
                value: value,
                child: Text(value ?? 'Sin prioridad'),
              );
            }).toList(),
          ),
        ],
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
              //actualizar el valor en la anomalía
              anomalia.prioridad = selectedPrioridad;
              // Actualiza la anomalía en el proveedor
              await ref
                  .read(anomaliaProvider.notifier)
                  .update(anomalia.id ?? "", anomalia);

              // Muestra un SnackBar con el mensaje de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se ha actualizado la prioridad con éxito'),
                  duration: Duration(seconds: 2), // Duración del SnackBar
                ),
              );
            }
          },
          child: const Text('Asignar Prioridad'),
        ),
      ],
    );
  }
}
