
import 'package:flutter/material.dart';

// ! CONSTRUCCION DE UN SNACKBAR
class CustomSnackBar {
  // * METODO
  static void snackBar( BuildContext context, String message, TextTheme textTheme, ColorScheme colorTheme, bool fountValue ){
    // ? LIMPIA TODOS LOS SNACKBARS ANTERIORES
    ScaffoldMessenger.of(context).clearSnackBars();
  
    // ? CREA EL NUEVO
    final snackBar = SnackBar(
      content: Text(
        message, 
        style: textTheme.bodyMedium?.copyWith(
          color: fountValue ? Colors.black : Colors.white
        ),
      ),
      behavior: SnackBarBehavior.floating,

      backgroundColor: colorTheme.primary,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
    );

    // ? LO MUESTRA
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}