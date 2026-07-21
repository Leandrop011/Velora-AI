

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const seedColor = Color(0xFF1E1C36);

class AppTheme {
  
  final bool isDarckMode;

  AppTheme({
    required this.isDarckMode
  });

  // * Metodo ThemeData 
  ThemeData getTheme() => ThemeData(
    brightness: isDarckMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: seedColor,

    // ? TEMA DE LOS LISTILE
    listTileTheme: const ListTileThemeData(
      iconColor: seedColor,
    ),

    // ? TEMA DE LOS APPBAR
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1C36),
      surfaceTintColor: Colors.transparent,
    ),

  );

  // * METODO ESTATICO PARA CAMBIAR EL ESTATUS BAR( EL SITIO DE LAS NOTIFICACION, 
  // * PARA QUE SE MODIFIQUE A BLANCO O OSCURO DEPENDIENDO EL TEMA)
  static void setSystemUiOverlayStyle({required bool isDarckMode}){

    final themeBrigthness = isDarckMode ? Brightness.dark : Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themeBrigthness,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: themeBrigthness,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

  }
}