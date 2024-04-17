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

  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> signUserIn(BuildContext context) async {
    try {
      prefs.usuario = usernameController.text;
      prefs.contrasena = passwordController.text;

      final resp = await ref
          .read(userAuthenticatedProviderr.notifier)
          .authenticate(prefs.usuario, prefs.contrasena);
      //final List<UserModel> users =  ref.watch(userAuthenticatedProviderr);
      if (resp != Null) {
        for (var element in resp) {
          if (element.username == "Admin" && element.password == "Admin") {
            // print(element.username );
            Navigator.of(context).pushNamed(HomeAdmin.nombre);
          } else {
            //print(element.username );
            ref.read(pkUserProvider.notifier).state = element.id!;
            Navigator.of(context).pushNamed(HomePage.nombre);
          }
        }
      } else {
        print("lista vacia");
      }
    } catch (e) {
      // Almacenar el contexto antes de entrar en el área asincrónica
      final currentContext = context;
      // Mostrar alerta en caso de error de autenticación
      showDialog(
        context: currentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error de autenticación"),
            content: const Text(
                "Credenciales incorrectas. Por favor, inténtalo de nuevo."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(currentContext)
                      .pop(); // Cerrar el diálogo de alerta
                },
              ),
            ],
          );
        },
      );
    }
  }

  void registerNow(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterPage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimapagina = LoginPage.nombre;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 0),

                // logo 
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundImage: AssetImage('assets/images/edificio.png'),

                  // child: SquareTile(imagePath: 'assets/images/edificio.png'),
                ),

                const SizedBox(height: 20),

                // welcome back
                const Text(
                  'Bienvenido!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  //hintText: 'Username',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Usuario o Correo",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo esta vacio");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  //hintText: 'Password',
                  obscureText: true,
                  maxLines: 1,
                  labelText: "Contraseña",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo esta vacio");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Olvidaste tu contraseña?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // sign in button
                MyButton(
                  title: 'Iniciar Sesión',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signUserIn(context);
                    }
                  },
                ),

                const SizedBox(height: 20),

                // or continue with
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tienes una cuenta?',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
