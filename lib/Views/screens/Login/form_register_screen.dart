import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Residente.dart';
import 'package:gestionresidencial/Views/Components/mybutton_component.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';
import 'package:gestionresidencial/main.dart';

class FormRegisterPage extends ConsumerStatefulWidget {
  const FormRegisterPage({Key? key}) : super(key: key);

  static const String nombre = 'Form Register';

  @override
  _FormRegisterPageState createState() => _FormRegisterPageState();
}

class _FormRegisterPageState extends ConsumerState<FormRegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final numberApartmentController = TextEditingController();

  void signUp(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      String idUserGot = ref.read(pkUserProvider.notifier).state;
      try {
        ResidenteModel residenteModel = ResidenteModel(
            // Asignar los valores del usuario desde los controladores
            nombreResidente: nameController.text,
            numApartamento: numberApartmentController.text,
            numTelefono: numberController.text,
            idUser: idUserGot);

        // Guardar el usuario usando UserProvider
        String response =
            await ref.read(residenteProvider.notifier).save(residenteModel);
        print('registro guardado con éxito: $response');

        Navigator.of(context).pushNamed(LoginPage.nombre);
      } catch (e) {
        print('Error al guardar el registro: $e');
        // Aquí puedes manejar el error, mostrar un mensaje al usuario, etc.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
                  'Enter your information!',
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
                  labelText: "Full name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo está vacío");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: numberApartmentController,
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Apartment Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo está vacío");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: numberController,
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Phone number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo está vacío");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MyButton(
                  title: 'Register',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signUp(context);
                    }
                  },
                ),
                const SizedBox(height: 20),
                // are a member? Log In
              ],
            ),
          ),
        ),
      ),
    );
  }
}
