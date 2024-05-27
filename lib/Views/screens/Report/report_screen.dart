// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';

import 'package:gestionresidencial/Views/Components/elevatedButton.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';

import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

class ReportPage {
  final String subject;
  final String description;
  final List<File> evidences;
  final String anomaly;

  ReportPage({
    required this.subject,
    required this.description,
    required this.evidences,
    required this.anomaly,
  });
}

class AppState {
  List<ReportPage> reports = [];
}

final appState = AppState();

// ignore: camel_case_types
class reporte extends ConsumerStatefulWidget {
  const reporte({super.key});

  static const String nombre = 'reporte';

  @override
  reporteState createState() => reporteState();
}

// ignore: camel_case_types
class reporteState extends ConsumerState<reporte> {
  final _formkey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<File> _evidences = [];

  final typeAnomaly = [
    "Seleccionar",
    "Infraestructura",
    "Seguridad",
    "Incidente Médico",
    "Servicios Públicos",
    "Otro"
  ];

  String selectedval = "";
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _evidences.add(File(pickedFile.path));
      });
    }
  }

  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    selectedval = typeAnomaly[0];
  }

  void _submitReport() async {
  if (_formkey.currentState!.validate()) {
    try {
      String idUserGot = ref.read(pkUserProvider.notifier).state;
      print("ID de usuario obtenido: $idUserGot");
      
      AnomaliaModel anomalia = AnomaliaModel(
        descripcionAnomalia: descriptionController.text,
        fechaReporteAnomalia: DateFormat('dd/MM/yyyy H:m').format(DateTime.now()),
        tipoAnomalia: selectedval,
        fotoAnomalia: 'img',
        idEstadoAnomalia: 'Pendiente',
        IdUser: idUserGot,
        asuntoAnomalia: subjectController.text,
      );

      print("Creando objeto AnomaliaModel");
      
      final token = await ref.read(anomaliaProvider.notifier).getToken();
      if (token.isNotEmpty) {
        print("Guardando anomalía");
        await ref.read(anomaliaProvider.notifier).saveAnomalia(anomalia, token);
        Navigator.of(context).pushNamed(HistorialPage.nombre);
      } else {
        print("Error: No se pudo obtener el token");
      }
    } catch (e) {
      print("Ocurrió un error durante el envío del reporte: $e");

    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmación'),
                  content:
                      const Text('¿Seguro que desea abandonar el reporte?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(HomePage.nombre),
                      child: const Text('Si'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Builder(
        builder: (context) {
          final Color primaryColor = Theme.of(context).primaryColor;
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, Colors.white54],
                    stops: const [0.1, 0.4],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Registro Reporte",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              shadows: [
                                Shadow(blurRadius: 0.5),
                              ],
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Divider(),
                    const SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FormReport(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Form FormReport() {
    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField(
                value: selectedval,
                items: typeAnomaly
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedval = val as String;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                validator: (value) {
                  if (value == typeAnomaly[0]) {
                    return ("Debe seleccionar el tipo de anomalia");
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            MyTextField(
              controller: subjectController,
              //hintText: 'Asunto',
              obscureText: false,
              maxLines: 1,
              labelText: "Asunto",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ("El asunto es requerido");
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            MyTextField(
                controller: descriptionController,
                //hintText: 'Descripcion',
                obscureText: false,
                maxLines: 5,
                labelText: "Descripcion",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("Se necesita una descripcion del problema");
                  }
                  return null;
                }),
            const SizedBox(height: 10.0),
            CustomElevatedButton(
              onPressed: _pickImage,
              title: const Text('Subir evidencia'),
            ),
            const SizedBox(height: 10.0),
            listEvidences(),
            const SizedBox(height: 10.0),
            CustomElevatedButton(
              onPressed: _submitReport,
              title: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox listEvidences() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _evidences.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(_evidences[index]),
          );
        },
      ),
    );
  }
}
