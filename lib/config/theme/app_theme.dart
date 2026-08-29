

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// const seedColor = Color(0xFF1E1C36);

List<(String,Color)> listColors = [
  ('Ambar', Colors.amber),
  ('Azul', Colors.blue),
  ('Cyan', Colors.cyan),
  ('Esmeralda', const Color.fromARGB(255, 86, 237, 189)),
  ('Indigo', Colors.indigo),
  ('Naranja', Colors.orange),
  ('Rosa', Colors.pink),
  ('Morado', Colors.purple),
  ('Rojo', Colors.red),
  ('Verde', Colors.green),
];


class AppTheme {
  
  final bool isDarckMode;
  final int colorValue;

  AppTheme({
    required this.isDarckMode, 
    required this.colorValue,
  });

  // * Metodo ThemeData 
  ThemeData getTheme() => ThemeData(
    brightness: isDarckMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: listColors[colorValue].$2,

    // ? TEMA DE LOS LISTILE
    listTileTheme: ListTileThemeData(
      iconColor: listColors[colorValue].$2,
    ),

    // ? TEMA DE LOS APPBAR
    // appBarTheme: AppBarTheme(
    //   backgroundColor: listColors[colorValue],
    //   surfaceTintColor: Colors.transparent,
    // ),

    // ? TEMA DE TEXTO
    textTheme: TextTheme(
      titleLarge: GoogleFonts.outfit().copyWith(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0),
      titleMedium: GoogleFonts.outfit().copyWith(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.1),
      titleSmall: GoogleFonts.outfit().copyWith(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.inter().copyWith(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      bodyMedium: GoogleFonts.inter().copyWith(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: GoogleFonts.inter().copyWith(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelMedium: GoogleFonts.lobster().copyWith(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    ),


  );

  // * METODO ESTATICO PARA CAMBIAR EL ESTATUS BAR( EL SITIO DE LAS NOTIFICACION, 
  // * PARA QUE SE MODIFIQUE A BLANCO O OSCURO DEPENDIENDO EL TEMA)
  static void setSystemUiOverlayStyle({required bool isDarckMode}){

    final themeBrigthness = isDarckMode ? Brightness.dark : Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themeBrigthness,
        statusBarColor: Colors.blue,
        statusBarIconBrightness: themeBrigthness,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

  }
}