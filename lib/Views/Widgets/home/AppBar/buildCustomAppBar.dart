import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class BuildCustomAppBar extends ConsumerStatefulWidget {
  const BuildCustomAppBar({super.key}) ;

  @override
  _BuildCustomAppBarState createState() => _BuildCustomAppBarState();
}

class _BuildCustomAppBarState extends ConsumerState<BuildCustomAppBar> {
  final prefs = PrefernciaUsuario();
  String dropdownValue = '';
  List<String> address = [];

  @override
  void initState() {
    super.initState();
    dropdownValue = prefs.apartment;
    address = [prefs.apartment]; // Inicializar la lista con el valor del apartamento
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: kToolbarHeight, // Altura de la barra de aplicación
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hola, ',
                  style: TextStyle(
                      fontSize: 34,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    // Acción para mostrar las notificaciones
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: kToolbarHeight, // Altura de la barra de aplicación
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              prefs.usuario,
              style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
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
                          Icon(
                            Icons.home,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          const SizedBox(width: 5),
                          Text(dropDownStringItem),
                        ],
                      ),
                    );
                  }).toList(),
                  elevation: 8,
                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value as String;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
