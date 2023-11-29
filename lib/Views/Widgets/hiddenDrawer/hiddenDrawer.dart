import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/Historial/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  static const nombre = 'hiddenDrawer';

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  String dropdownValue = '';
  final address = ['Apto 414 - Edificio Burj Khalifa'];

  final textStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);

  @override
  void initState() {
    super.initState();

    dropdownValue = address[0];

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: textStyle,
          selectedStyle: textStyle,
        ),
        const MyHomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Historial',
          baseStyle: textStyle,
          selectedStyle: textStyle,
        ),
        const HistorialPage(
          reports: [],
        ),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Chat',
          baseStyle: textStyle,
          selectedStyle: textStyle,
        ),
        const ChatPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: theme.primaryColor,
      initPositionSelected: 0,
      actionsAppBar: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.withOpacity(0.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: dropdownValue,
              items: address.map((String dropDownStringItem) {
                return DropdownMenuItem(
                  onTap: () {},
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      const Icon(Icons.home),
                      const SizedBox(width: 5),
                      Text(dropDownStringItem),
                    ],
                  ),
                );
              }).toList(),
              elevation: 8,
              style: const TextStyle(color: Colors.black),
              underline: const SizedBox(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value as String;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
