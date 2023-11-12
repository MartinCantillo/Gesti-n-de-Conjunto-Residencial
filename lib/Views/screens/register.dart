import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Components/mybutton2.dart';
import 'package:gestionresidencial/Views/Components/mybutton3.dart';
import 'package:gestionresidencial/Views/Components/mytextfield.dart';
import 'package:gestionresidencial/Views/Components/squaretile.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:gestionresidencial/Views/screens/login.dart';



class Register extends StatefulWidget {
  const Register({super.key});

  static const String nombre = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
final prefs = PrefernciaUsuario();
final usernameController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();



  // sign user in method
  void signUp(BuildContext context) {
    prefs.usuario = usernameController.text;
    prefs.contrasena = passwordController.text;
    print (prefs.usuario);
    Navigator.of(context).pushNamed(LoginPage.nombre);
  }
  void Loginow(BuildContext context) {
    print (prefs.usuario);
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

              // welcome back
              Text(
                'Welcome to create an account!',
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

               // confirm password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  MyButton2(
                    onTap: () {
                      signUp(context); // Pasa el contexto
                    },
                  ),
                  // sign up button
                  MyButton3(
                    onTap: () {
                      signUp(context); // Pasa el contexto
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),

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
                    const SizedBox(
                      height: 60
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
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: (){
                      Loginow(context);
                      },
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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