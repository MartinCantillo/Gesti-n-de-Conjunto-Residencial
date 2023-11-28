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
  final _formkey = GlobalKey<FormState>();
  final prefs = PrefernciaUsuario();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final numberController = TextEditingController();
  final numberApartmentController = TextEditingController();


  // sign user in method
  void signUp(BuildContext context) {
    prefs.usuario = emailController.text;
    prefs.contrasena = passwordController.text;
    Navigator.of(context).pushNamed(LoginPage.nombre);
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
                MyTextField(
                  controller: nameController,
                  hintText: 'Full name',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Full name",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
          
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Email",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 10),
          
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  maxLines: 1,
                  labelText: "Password",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 10),
          
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  maxLines: 1,
                  labelText: "Confirm Password",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 10),
          
                MyTextField(
                  controller: numberApartmentController,
                  hintText: 'Apartment Number',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Apartment Number",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
          
                MyTextField(
                  controller: numberController,
                  hintText: 'Phone number',
                  obscureText: false,
                  maxLines: 1,
                  labelText: "Phone number",
                  validator: (value){
                    if (value == null||value.isEmpty) {
                      return("El campo esta vacio");
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
                    if(_formkey.currentState!.validate())
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
