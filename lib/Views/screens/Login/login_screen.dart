import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/Components/mybutton_component.dart';
import 'package:gestionresidencial/Views/Components/mybutton2_component.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/Components/squaretile_component.dart';
import 'package:gestionresidencial/Views/screens/Home/HomeAdmin/HomeA.dart';

import 'package:gestionresidencial/Views/screens/Home/HomePage.dart';
import 'package:gestionresidencial/Views/screens/Login/register_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:gestionresidencial/main.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String nombre = 'login';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final prefs = PrefernciaUsuario();
  bool _isLoading = false;

  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> signUserIn(BuildContext context) async {
  setState(() {
    _isLoading = true;
  });

  try {
    prefs.usuario = usernameController.text;
    prefs.contrasena = passwordController.text;

    final resp = await ref
        .read(userAuthenticatedProviderr.notifier)
        .authenticateUser(prefs.usuario, prefs.contrasena);

    if (resp != null && resp.isNotEmpty) { // Comprobar si la respuesta no es nula y no está vacía
      final element = resp[0]; // Solo tomamos el primer elemento de la lista, si la hay

      if (element.username == "Admin@gmail.com" && element.password == "Admin123") {
        Navigator.of(context).pushNamed(HomeAdmin.nombre);
      } else {
        if (element.id != null) { // Comprobar si el ID no es nulo
          ref.read(pkUserProvider.notifier).state = element.id!;
          Navigator.of(context).pushNamed(HomePage.nombre);
        } else {
          print("ID de usuario es nulo");
        }
      }
    } else {
      print("Lista de respuesta vacía");
    }
  } catch (e) {
    print("Error: $e");
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  void registerNow(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterPage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimapagina = LoginPage.nombre;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 100.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      backgroundImage:
                          const AssetImage('assets/images/edificio.png'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenido!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      controller: usernameController,
                      obscureText: false,
                      maxLines: 1,
                      labelText: "Usuario o Correo",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("El campo está vacío");
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
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    MyButton(
                      title: 'Iniciar Sesión',
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          signUserIn(context);
                        }
                      },
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'o Continúa con',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'assets/images/google.png'),
                        SizedBox(width: 25),
                        SquareTile(imagePath: 'assets/images/apple.png'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes una cuenta?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        MyButton2(
                          title: 'Registrarse',
                          onTap: () {
                            registerNow(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
