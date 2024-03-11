import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildCustomAppBar extends ConsumerStatefulWidget {
  const BuildCustomAppBar({super.key});

  @override
  ConsumerState<BuildCustomAppBar> createState() => _BuildCustomAppBarState();
}

class _BuildCustomAppBarState extends ConsumerState<BuildCustomAppBar> {

  String dropdownValue = '';
  final address = ['Apto 414 - Torre 4'];

  final textStyle = const TextStyle(
    fontWeight: FontWeight.bold, 
    fontSize: 16, 
    color: Colors.white,
  );
  

  @override
  void initState() {
    super.initState();
    dropdownValue = address[0];
  }

  

  @override
  Widget build(BuildContext context) {
    final String userName = 'Usuario';
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
              userName,
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
