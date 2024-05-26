import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:gestionresidencial/Models/Banner.dart';

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
  late Future<List<AnomaliaModel>> anomaliasList = Future.value([]);
  late Future<List<BannerModel>>  bannersList;
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    // String idUserGot = "123";
    // anomaliasList =ref.read(anomaliaProvider.notifier).getAnomaliaById(idUserGot);
    bannersList = ref.read(bannerProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: anomaliasList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || (snapshot.data as List).isEmpty) {
          return buildBody(context, dataVacia, []);
        } else {
          return buildBody(context, snapshot.data, bannersList);
        }
      },
    );
  }
  

  Widget buildBody(BuildContext context, dynamic data, dynamic bannerList) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
              ),
              height: 56 + MediaQuery.of(context).padding.top,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // Puedes cambiar el color según tus preferencias
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                ],
              ),
            ),
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
                        height: MediaQuery.of(context).size.height * 0.31,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: ShapeClipperAppBar(),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: MediaQuery.of(context).size.height * 0.29,
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
                  child: build2(context),
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
        const SizedBox(height: 2),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.31,
          child: ListView.builder(
            itemCount: data.length > 3 ? 3 : data.length,
            itemBuilder: (context, index) {
              final AnomaliaModel anomalia = data[index] ?? "";
              return Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  title: Text(anomalia.tipoAnomalia ?? ""),
                  trailing: Text(
                    anomalia.idEstadoAnomalia ?? "",
                    style: TextStyle(
                        color: Estadoanomaliacolor
                            .estadoColor[anomalia.idEstadoAnomalia]),
                  ),
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
  Widget build2(BuildContext context) {
  return FutureBuilder(
    future: bannersList,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError || (snapshot.data as List).isEmpty) {
        return Container(); // Podemos devolver un widget vacío si no hay banners
      } else {
        return buildBannerCarousel(snapshot.data!); // Pasamos snapshot.data directamente
      }
    },
  );
}

  final List<AnomaliaModel> dataVacia = [];

   Widget buildBannerCarousel(List<BannerModel> banners) {
  return CarouselSlider(
    options: CarouselOptions(viewportFraction: 1, autoPlay: true,height: MediaQuery.of(context).size.height * 0.2),
    items: [
      // Agregar la imagen como primer elemento
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              "assets/images/new.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      ...banners.map((banner) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        banner.fecha ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    banner.titulo ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    banner.descripcion ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ],
  );
}
}