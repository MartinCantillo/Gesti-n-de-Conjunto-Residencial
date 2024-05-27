// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/User.dart';

import 'package:gestionresidencial/Views/Components/mybutton_component.dart';
import 'package:gestionresidencial/Views/Components/mybutton2_component.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';

import 'package:gestionresidencial/Views/screens/Login/form_register_screen.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String nombre = 'Register';

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final prefs = PrefernciaUsuario();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final numberController = TextEditingController();
  final numberApartmentController = TextEditingController();

  // sign user in method
  void signUp(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      UserModel userModel = UserModel(
        // Asignar los valores del usuario desde los controladores
        username: emailController.text,
        password: passwordController.text,
      );

      try {
        // Guardar el usuario usando UserProvider
        String pkUsuario = await ref.watch(userProvider.notifier).saveUser(userModel);

        //Actualizar estado pkUser
        ref.watch(pkUserProvider.notifier).state = pkUsuario;

        // Mostrar un aviso de registro exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("¡Registro exitoso!"),
            duration: Duration(seconds: 2),
          ),
        );

        //llevar a pagina de registro de formulario
        Navigator.of(context).pushNamed(FormRegisterPage.nombre);
      } catch (e) {
        throw ('Error al guardar el registro: $e');
      }
    }
  }

  void logiNow(BuildContext context) {
    Navigator.of(context).pushNamed(LoginPage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    String? passwordError;
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock,
                            size: 100,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Bienvenido, crea una cuenta!',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextField(
                            controller: emailController,
                            obscureText: false,
                            maxLines: 1,
                            labelText: "Correo",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("El campo está vacío");
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return "Ingresa un correo válido";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: passwordController,
                            obscureText: true,
                            maxLines: 1,
                            labelText: "Contraseña",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("El campo está vacío");
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                  .hasMatch(value)) {
                                return "La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número";
                              } else if (passwordController.value !=
                                      confirmPasswordController.value &&
                                  !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                      .hasMatch(value)) {
                                return "La contraseña no coincide";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            maxLines: 1,
                            labelText: "Confirmar contraseña",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ("El campo está vacío");
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                  .hasMatch(value)) {
                                return "La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número";
                              } else if (confirmPasswordController.value !=
                                  passwordController.value) {
                                return "La contraseña no coincide";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      // forgot password?
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      ),

                      const SizedBox(height: 20),

                      MyButton(
                        title: 'Registrarse',
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            signUp(context);
                          }
                        },
                        isLoading: false,
                      ),

                      const SizedBox(height: 20),

                      // are a member? Log In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ya tienes una cuenta?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          MyButton2(
                            title: 'Sign In',
                            onTap: () {
                              logiNow(context);
                            },
                          ),
                        ],
                      ),
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
