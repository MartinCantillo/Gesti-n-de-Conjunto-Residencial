import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/Widgets/home/Body/bodyHome.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static String nombre = 'homepage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: const BodyHome(),
        floatingActionButton: addButton(),
      ),
    );
  }

  FloatingActionButton addButton() {
    return FloatingActionButton(
        onPressed: () {
          
        },
        tooltip: 'Agregar',
        child: const Icon(
          Icons.add_rounded,
        ),
        
        
      );
  }
}
  
AppBar buildAppBar() {
  return AppBar(
    title: const Text('Hola,', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 32),),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_outlined),
        color: Colors.white,
        onPressed: () {},
      ),
    ],
    backgroundColor: Colors.blue,
  );
}
