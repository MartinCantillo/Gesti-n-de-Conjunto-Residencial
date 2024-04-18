import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:intl/intl.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';

import 'package:gestionresidencial/Views/Components/mybutton2_component.dart';

import 'package:gestionresidencial/Views/Widgets/home/waveClipper/ShapeClipperAppBar.dart';

import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

class BodyHome extends ConsumerStatefulWidget {
  const BodyHome({super.key});

  static String nombre = "bodyHome";

  @override
  BodyHomeState createState() => BodyHomeState();
}

class BodyHomeState extends ConsumerState<BodyHome> {
  late Future<List<AnomaliaModel>> anomaliasList;
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    // String idUserGot = "123";
    anomaliasList =
        ref.read(anomaliaProvider.notifier).getAnomaliaById(idUserGot);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: anomaliasList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || (snapshot.data as List).isEmpty) {
          return buildBody(context, dataVacia);
        } else {
          return buildBody(context, snapshot.data);
        }
      },
    );
  }

  Widget buildBody(BuildContext context, dynamic data) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: ClipPath(
                      clipper: ShapeClipperAppBar(),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        height: MediaQuery.of(context).size.height * 0.35,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: ShapeClipperAppBar(),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: MediaQuery.of(context).size.height * 0.33,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.32,
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                SizedBox(
                  child: dateCardWidget(),
                ),
                Expanded(
                  child: buildBannerNotification(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: listMisReportes(data),
        ),
      ],
    );
  }

  Column listMisReportes(data) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Reportes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyButton2(
              title: 'Ver todos',
              onTap: () {
                Navigator.of(context).pushNamed(HistorialPage.nombre);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            itemCount: data.length > 3 ? 3 : data.length,
            itemBuilder: (context, index) {
              final AnomaliaModel anomalia = data[index] ?? "";
              return Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  title: Text(anomalia.tipoAnomalia ?? ""),
                  trailing: const Text('Pendiente'),
                  subtitle: Text(anomalia.fechaReporteAnomalia ?? ""),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget dateCardWidget() {
    return Column(
      children: [
        Text(
          DateFormat.MMM().format(DateTime.now()),
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    DateFormat.d().format(
                        DateTime.now()), // Muestra el día actual en números
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    DateFormat.EEEE().format(
                        DateTime.now()), // Muestra el día actual en letras
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  final List<AnomaliaModel> dataVacia = [];

  Widget buildBannerNotification() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(viewportFraction: 1, autoPlay: true),
          items: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Opacity(
                opacity: 0.9,
                child: Image.asset("assets/images/new.png",
                  fit: BoxFit.fill,
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Administración',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            DateFormat.Hm().format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Mantenimiento del Lobby',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Lorem ipsum dolor',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
