import 'package:flutter/material.dart';
import '../shared/theme/theme.dart';
import '../shared/theme/util.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    // Usamos el generador de temas que tienes en shared
    final textTheme = createTextTheme(context, "Roboto", "Merriweather");
    final materialTheme = MaterialTheme(textTheme);
    
    // Retornamos el tema light por defecto, pero podrías alternar
    return materialTheme.light().copyWith(
      // Añadimos personalizaciones específicas para el estilo de biblioteca
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      cardTheme: CardThemeData( // Corregido: CardThemeData en lugar de CardTheme
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
