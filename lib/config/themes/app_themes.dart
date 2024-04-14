import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define los temas disponibles
enum AppTheme {
  Light,
  Dark,
}

// Define el provider para manejar el estado del tema
final themeProvider = StateProvider<AppTheme>((ref) => AppTheme.Light);

// Método para obtener el tema actual
ThemeData getThemeData(AppTheme theme) {
  const List<Color> colorThemes = [
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red
  ];

  const selectedColor = 1; // O el color seleccionado que desees

  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorThemes[selectedColor],
    brightness: theme == AppTheme.Dark ? Brightness.dark : Brightness.light,
    listTileTheme: ListTileThemeData(
      iconColor: colorThemes[selectedColor],
    ),
  );
}
