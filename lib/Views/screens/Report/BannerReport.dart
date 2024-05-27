// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Banner.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historialbanner_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';
import 'package:intl/intl.dart';


class BannerReport extends ConsumerStatefulWidget {
  const BannerReport({Key? key}) : super(key: key);
  static const String nombre = 'Banner';
  @override
  _BannerReportState createState() => _BannerReportState();
}

class _BannerReportState extends ConsumerState<BannerReport> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  // Agrega aquí controladores para otros campos del banner si es necesario

  final prefs = PrefernciaUsuario();
  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      try {
        //  print("id user enviado a anomalia${idUserGot}");
        BannerModel banner = BannerModel(
            titulo: _tituloController.text,
            descripcion: _descripcionController.text,
            fecha: DateFormat('dd/MM/yyyy HH:m').format(DateTime.now()),
            );
        print("Creando objeto bannerModel");
      
      final token = await ref.read(anomaliaProvider.notifier).getToken();
      if (token.isNotEmpty) {
        print("Guardando banner");
        await ref.read(bannerProvider.notifier).save(banner, token);
        Navigator.pushReplacementNamed(context, BannerReport.nombre);
        }
      } catch (e) {
        throw ('Error al enviar el reporte: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Banner'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, BannerScreen.nombre);
            },
            icon: const Icon(Icons.settings), // Cambia el icono según tu preferencia
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextField(
                    controller: _tituloController,
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un título';
                      }
                      return null;
                    }, obscureText: false, maxLines: 2, labelText: 'Titulo',
                  ),
                  const SizedBox(height: 10.0),
                  MyTextField(
                    controller: _descripcionController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una descripción';
                      }
                      return null;
                    }, obscureText: false, labelText: 'Descripcion',
                  ),
                  const SizedBox(height: 10.0),
                  const Expanded(child: SizedBox(height: 10.0)),
                  // Agrega aquí campos adicionales para el banner si es necesario
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitReport();
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}