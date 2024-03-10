import 'package:flutter/material.dart';

class LoginPageNew extends StatelessWidget {
  const LoginPageNew({super.key});

  static String nombre =  "newLoginPage";

   @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('background_login.png'), // Aquí debes proporcionar la ruta de la imagen
          fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el contenedor
        ),
      ),
      child: YourContentWidget(), // Aquí colocas el resto de tu contenido
    );
  }
}

class YourContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Image Example'),
      ),
      body: Center(
        child: Text(
          'Contenido de tu aplicación',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}