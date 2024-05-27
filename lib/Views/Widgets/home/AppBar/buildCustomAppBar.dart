import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Residente.dart';

import 'package:gestionresidencial/Views/screens/Notification/notification_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

class BuildCustomAppBar extends ConsumerStatefulWidget {
  const BuildCustomAppBar({super.key});

  @override
  _BuildCustomAppBarState createState() => _BuildCustomAppBarState();
}

class _BuildCustomAppBarState extends ConsumerState<BuildCustomAppBar> {
  late Future<List<ResidenteModel>> residenteList = Future.value([]);
  final prefs = PrefernciaUsuario();
  String dropdownValue = '';
  List<String> address = [];

    @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String idUserGot = ref.read(pkUserProvider.notifier).state;
    String token = await ref.read(anomaliaProvider.notifier).getToken(); // Obtén el token
    residenteList = ref.read(residenteProvider.notifier).getResidenteById(idUserGot, token);  // Pasa el token a la función
    setState(() {});  // Actualiza el estado
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: residenteList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || (snapshot.data as List).isEmpty) {
          print("Snapshot error: ${snapshot.error}");
          return buildbody(context, null); // Mostrar un cuerpo vacío o un mensaje de error
        } else {
          return buildbody(context, snapshot.data);
        }
      },
    );
  }
  Widget buildbody(BuildContext context, List<ResidenteModel>? residenteData) {
    final residente = residenteData?.first;
    address = residenteData?.map((residente) => residente.numApartamento ??"").toList()??[];
    dropdownValue = residente?.numApartamento ?? "";
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: kToolbarHeight, // Altura de la barra de aplicación

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hola, ',
                  style: TextStyle(
                    fontSize: 34,
                    color: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(NotificationPage.nombre);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: kToolbarHeight, // Altura de la barra de aplicación
            child: Text(
              residente?.nombreResidente ?? "",
              style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: dropdownValue,
                  items: address.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      onTap: () {},
                      value: dropDownStringItem,
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          const SizedBox(width: 5),
                          Text('Apto $dropDownStringItem'),
                        ],
                      ),
                    );
                  }).toList(),
                  elevation: 8,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  // Cambia el color del botón cuando está en foco
                  dropdownColor:
                      Theme.of(context).primaryColor.withOpacity(0.8),
                  // Aumenta el tamaño del ícono cuando está en foco
                  iconSize: 30,
                  // Ajusta el borde del botón cuando está en foco
                  borderRadius: BorderRadius.circular(25),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value as String;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
