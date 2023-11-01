import 'package:flutter/material.dart';
import 'package:gestionresidencial/components/mybutton.dart';
import 'package:gestionresidencial/components/mytextfield.dart';
import 'package:gestionresidencial/components/squaretile.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:gestionresidencial/screens/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String nombre = 'login';
  final prefs = PrefernciaUsuario();

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    prefs.usuario = usernameController.text;
    prefs.contrasena = passwordController.text;
    print (prefs.usuario);
    Navigator.of(context).pushNamed(HomePage.nombre);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimapagina = LoginPage.nombre;
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
                Icons.person,
                size: 100,
                color: Colors.black,
              ),

              const SizedBox(height: 20),

              // welcome back
              Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // sign in button
              MyButton(
                onTap: () {
                  signUserIn(context); // Pasa el contexto
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
                        'Or continue with',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
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