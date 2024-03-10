import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Provider/todoProvider/todoProvider.dart';
import 'package:gestionresidencial/Views/Widgets/WidgetsAdmin/NavbarAdmin.dart';
import 'package:gestionresidencial/Views/screens/Report/detalleReportes.dart';

class HomeAdmin extends ConsumerWidget {
  const HomeAdmin({super.key});
  
  static const String nombre = 'HomeAdmin';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reportes'),
      ),
      body: const _ReportListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.message ),
        onPressed: () {
          
        },
      ),
    );
  }
}


class _ReportListView extends ConsumerWidget {
  const _ReportListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentFilter = ref.watch(todoFilterProvider);


    return Column(
      children: [
        const ListTile(
          title: Text('Listado de reportes'),
          subtitle: Text('Estos son los reportes hechos por los residentes'),
        ),

        SegmentedButton(
          segments: const[
            ButtonSegment(value: TodoFilter.all, icon: Text('Todos')),
            ButtonSegment(value: TodoFilter.completed, icon: Text('Completados')),
            ButtonSegment(value: TodoFilter.pending, icon: Text('Pendientes')),
          ], 
          selected: <TodoFilter>{ currentFilter },
          onSelectionChanged: (value) {
            ref.read(todoFilterProvider.notifier).state = value.first;
          },
        ),
        const SizedBox( height: 5 ),

        /// Listado de reportes
        Expanded(
          child: ListView.builder(
            //itemCount: todos.length,
            itemBuilder: (context, index) {
               return GestureDetector(
                onTap: () {
                  // Navegar a otra pantalla sin activar el switch
                 Navigator.pushNamed( context, DetalleReportes.nombre);
                 print('clic');
                },
                child: const Card(
                  child: ListTile(
                    title: Text('Asunto'),
                    subtitle: Text('Descripción del reporte'),
                    trailing: Text('Fecha del reporte'),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
