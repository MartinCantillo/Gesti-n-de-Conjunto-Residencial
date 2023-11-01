import 'package:flutter/material.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String nombre = 'home';
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final prefs = PrefernciaUsuario();
  int _currentIndex = 0;

  final screens = [
    const Center(child: Text('Favorites Screen', style: TextStyle(fontSize: 45))),
    const Center(child: Text('Search Screen', style: TextStyle(fontSize: 45))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 45))),
  ];
  final colors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: colors[_currentIndex],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: GNav(
          color: colors[_currentIndex],
          tabBackgroundColor: colors[_currentIndex],
          selectedIndex: _currentIndex,
          tabBorderRadius: 10,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          onTabChange: (index) => {setState(() => _currentIndex = index)},
          tabs: const [
            GButton(
              icon: Icons.home,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.explore,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.settings,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}