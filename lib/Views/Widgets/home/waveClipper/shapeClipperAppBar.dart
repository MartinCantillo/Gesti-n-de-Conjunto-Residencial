

import 'package:flutter/material.dart';

class ShapeClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    debugPrint(size.width.toString());

    //Línea/punto inicial  de la curva
    path.lineTo(0, size.height);

    //primera curva
    var firstStartPoint = Offset(size.width / 5, size.height); //primer punto
    var firstEndPoint = Offset(size.width / 2.25, size.height - 50); //segundo punto
    path.quadraticBezierTo(firstStartPoint.dx, firstStartPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy); //dibujar la curva

    //segunda curva
    var secondStartPoint = Offset(
        size.width - (size.width / 3.24), size.height - 105); //tercer punto
    var secondEndPoint = Offset(size.width, size.height - 10); //cuarto punto
    path.quadraticBezierTo(secondStartPoint.dx, secondStartPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    // úlima línea/punto de la curva
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}