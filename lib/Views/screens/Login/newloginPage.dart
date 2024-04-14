import 'package:flutter/material.dart';

class LoginPageNew extends StatelessWidget {
  const LoginPageNew({super.key});

  static String nombre =  "newLoginPage";

   @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('background_login.png'), // Aquí debes proporcionar la ruta de la imagen
          fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el contenedor
        ),
      ),
      child: const YourContentWidget(), // Aquí colocas el resto de tu contenido
    );
  }
}

class YourContentWidget extends StatelessWidget {
  const YourContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Image Example'),
      ),
      body: const Center(
        child: Text(
          'Contenido de tu aplicación',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}