import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:image_picker/image_picker.dart';

class ReportPage {
  final String type;
  final String subject;
  final String description;
  final List<File> evidences;
  final String anomaly;

  ReportPage({
    required this.type,
    required this.subject,
    required this.description,
    required this.evidences,
    required this.anomaly,
  });
  Report.empty()
      : type = '',
        subject = '',
        description = '',
        evidences = [],
        anomaly = '';
}

class AppState {
  List<ReportPage> reports = [];
}

final appState = AppState();

// ignore: camel_case_types
class reporte extends StatefulWidget {
  const reporte({super.key});

  static const String nombre = 'reporte';

  @override
  State<reporte> createState() => _reporteState();
}

// ignore: camel_case_types
class _reporteState extends State<reporte> {
  final typeController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<File> _evidences = [];
  final TypeAnomaly = [
    "Infrastructura",
    "Seguridad",
    "Incidente medico",
    "Servicios publicos",
    "Otros"
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
    selectedval = TypeAnomaly[0];
  }

  void _submitReport() {
    // Aquí podemos manejar la lógica para enviar el reporte
    // Podemos acceder a los valores a través de typeController.text, subjectController.text, descriptionController.text
    // y las imágenes en _evidences

    List<ReportPage> reports = [
      ReportPage(
        type: typeController.text,
        subject: subjectController.text,
        description: descriptionController.text,
        evidences: _evidences,
        anomaly: selectedval,
      ),
    ];

    appState.reports.addAll(reports);
    Navigator.of(context).popAndPushNamed(MyHomePage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario Reporte',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(MyHomePage.nombre);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField(
                value: selectedval,
                items:TypeAnomaly.map(
                (e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                onChanged: (val){
                  setState(() {
                    selectedval= val as String;
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
              )
                ),
            ),
            const SizedBox(height: 16.0),
            MyTextField(
                controller: subjectController,
                hintText: 'Asunto',
                obscureText: false,
                maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            MyTextField(
                controller: descriptionController,
                hintText: 'Descripcion',
                obscureText: false,
                maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
              ),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle( 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  child: const Text('Subir Evidencias'),
                ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 100.0,
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
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
              ),
                child: ElevatedButton(
                  onPressed: _submitReport,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle( 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  child: const Text('Enviar Reporte'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
