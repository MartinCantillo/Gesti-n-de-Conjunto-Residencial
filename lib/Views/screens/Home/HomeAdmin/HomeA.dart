import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Provider/todoProvider/todoProvider.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';
import 'package:gestionresidencial/main.dart';

class HomeAdmin extends ConsumerStatefulWidget {
  const HomeAdmin({super.key});

  static const String nombre = 'HomeAdmin';

  @override
  ConsumerState<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends ConsumerState<HomeAdmin> {
  @override
  void initState() {
    super.initState();
  }

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
          Navigator.pushNamed(
                                  context, ChatPage.nombre);
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
                List<AnomaliaModel>? listaA = snapshot.data;
                if (listaA != null) {
                  return ListView.builder(
                    itemCount: listaA.length,
                    itemBuilder: (context, index) {
                      final AnomaliaModel? datosA = snapshot.data?[index];

                      return GestureDetector(
                        onTap: () {
                          // Navegar a otra pantalla sin activar el switch
                          Navigator.pushNamed(context, DetalleReportes.nombre);
                          print('clic');
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(datosA?.asuntoAnomalia ?? ''),
                            subtitle: Text(datosA?.descripcionAnomalia ?? ''),
                            trailing: Text(datosA?.fechaReporteAnomalia ?? ''),
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
}
