import "package:flutter/material.dart";

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';

import 'package:gestionresidencial/main.dart';

class ListAnomalias extends ConsumerStatefulWidget {
  const ListAnomalias({super.key});
  static const String nombre = 'ListAnomalias';
  @override
  ConsumerState<ListAnomalias> createState() => _ListAnomaliasState();
}

class _ListAnomaliasState extends ConsumerState<ListAnomalias> {
  late Future<List<AnomaliaModel>> anomaliasList;

  @override
  void initState() {
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    // anomaliasList =
        // ref.read(anomaliaProvider.notifier).getAnomaliaById(idUserGot);

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detalles del Reporte'),
        centerTitle: true,
      ),
      body: FutureBuilder(
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
              return GridView.count(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 2,
                  crossAxisCount: 2,
                  children: upload(snapshot.data));
            }
          }),
    ));
  }
}

List<Widget> upload(data) {
  List<Widget> dataList = [];

  if (data != null) {
    for (var element in data) {
      dataList.add(Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(element.fechaReporteAnomalia),
            const SizedBox(height: 8),
            Text('DescripcionA${element.descripcionAnomalia}'),
            const SizedBox(height: 8),
            Text('asuntoAnomalia${element.asuntoAnomalia}'),
            const SizedBox(height: 8),
            Text('tipoAnomalia${element.tipoAnomalia}'),
            const SizedBox(height: 8),
            Text('fotoAnomalia${element.fotoAnomalia}'),
            const SizedBox(height: 8),
          ],
        ),
      ));
    }
    return dataList;
  } else {
    return [];
  }
}
