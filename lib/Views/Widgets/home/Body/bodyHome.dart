import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Widgets/home/waveClipper/ShapeClipperAppBar.dart';
import 'package:gestionresidencial/Views/Widgets/home/NavBar/FloatingNavBar.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Opacity(opacity: 0.5,
                    child: ClipPath(
                    clipper: ShapeClipperAppBar(),
                    child: Container(
                      color: Colors.blue,
                      height: 200,
                      alignment: Alignment.center,
                    ),
                  ),
                  ),
                  ClipPath(
                    clipper: ShapeClipperAppBar(),
                    child: Container(
                      color: Colors.blue,
                      height: 180,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Positioned(
          bottom: 10,
          left: 0,
          right: 60,
          child: FloatingNavBar(),
        ),
      ],
    );
  }
}