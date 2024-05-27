import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Residente.dart';

import 'package:gestionresidencial/Views/Components/mybutton_component.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';

import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

class FormRegisterPage extends ConsumerStatefulWidget {
  const FormRegisterPage({Key? key}) : super(key: key);

  static String nombre = 'FormRegister';

  @override
  ConsumerState createState() => _FormRegisterPageState();
}

class _FormRegisterPageState extends ConsumerState<FormRegisterPage> {
  final prefs = PrefernciaUsuario();
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final numberController = TextEditingController();
  final numberApartmentController = TextEditingController();

  void signUp(BuildContext context) async {
  if (_formkey.currentState!.validate()) {
    String idUserGot = ref.read(pkUserProvider);
    try {
      prefs.nombreusuario = nameController.text;
      ResidenteModel residenteModel = ResidenteModel(
        nombreResidente: nameController.text,
        apellidoResidente: lastnameController.text,
        numApartamento: numberApartmentController.text,
        numTelefono: numberController.text,
        idUser: idUserGot,
      );
      prefs.apartment = numberApartmentController.text;

      // Guardar el usuario usando ResidenteProvider
      String response = await ref.read(residenteProvider.notifier).save(residenteModel);
      print('Registro guardado con éxito: $response');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡Guardado exitoxamente!"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushNamed(HomePage.nombre);
    } catch (e) {
      print('Error al guardar el registro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar el registro: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 0),
                      // logo
                      const Icon(
                        Icons.account_box,
                        size: 150,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ingresa tu información!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: nameController,
                        obscureText: false,
                        maxLines: 1,
                        labelText: "Nombres",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("El campo está vacío");
                          } else if (value.length < 3) {
                            return "Este campo debe tener al menos 3 caracteres";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: lastnameController,
                        obscureText: false,
                        maxLines: 1,
                        labelText: "Apellidos",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("El campo está vacío");
                          } else if (value.length < 3) {
                            return "Este campo debe tener al menos 3 caracteres";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: numberApartmentController,
                        obscureText: false,
                        maxLines: 1,
                        labelText: "Número de Apartmento",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("El campo está vacío");
                          } else if (!RegExp(r'^\d{3}$').hasMatch(value)) {
                            return "El número de apartamento debe tener 3 dígitos";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: numberController,
                        obscureText: false,
                        maxLines: 1,
                        labelText: "Número de Teléfono",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ("El campo está vacío");
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Ingrese un número de teléfono válido";
                          } else if (value.length < 10) {
                            return "El número de teléfono debe tener al menos 10 dígitos";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        title: 'Guardar',
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            signUp(context);
                          }
                        },
                        isLoading: false,
                      ),
                      const SizedBox(height: 20),
                      // are a member? Log In
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
