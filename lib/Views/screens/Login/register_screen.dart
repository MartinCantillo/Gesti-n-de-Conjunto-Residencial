import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/Models/Residente.dart';
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
        String pkUsuario =
            await ref.read(userProvider.notifier).save(userModel);

        //Actualizar estado pkUser
        ref.read(pkUserProvider.notifier).state = pkUsuario;

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
                  Icons.lock,
                  size: 100,
                  color: Colors.black,
                ),

                const SizedBox(height: 20),

                Text(
                  'Welcome to create an account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                const SizedBox(height: 10),

                MyTextField(
                  controller: emailController,
                  //hintText: 'Email',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo esta vacio");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  //hintText: 'Password',
                  obscureText: true,
                  maxLines: 1,
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo esta vacio");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  //hintText: 'Confirm Password',
                  obscureText: true,
                  maxLines: 1,
                  labelText: "Confirm Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("El campo esta vacio");
                    }
                    return null;
                  },
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
                  title: 'Register',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signUp(context);
                    }
                  },
                ),

                const SizedBox(height: 20),

                // are a member? Log In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
