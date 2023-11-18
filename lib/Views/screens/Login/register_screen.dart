import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Components/mybutton_component.dart';
import 'package:gestionresidencial/Views/Components/mybutton2_component.dart';
import 'package:gestionresidencial/Views/Components/mytextfield_component.dart';
import 'package:gestionresidencial/Views/screens/Login/login_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String nombre = 'Register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final prefs = PrefernciaUsuario();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUp(BuildContext context) {
    prefs.usuario = usernameController.text;
    prefs.contrasena = passwordController.text;
    Navigator.of(context).pushNamed(LoginPage.nombre);
  }

  void Loginow(BuildContext context) {
    Navigator.of(context).pushNamed(LoginPage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
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

              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                maxLines: 1,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                maxLines: 1,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                maxLines: 1,
              ),

              const SizedBox(height: 10),

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
                  signUp(context);
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
                      Loginow(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
