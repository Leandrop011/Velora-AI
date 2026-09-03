
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! CREAMOS ESTE PROVIDER CON EL OBJETIVO DE EMITIR VALORES PARA EL LINEARPROGRESSINDICATOR 

final valueLoaderProvider = StreamProvider.autoDispose<int>((ref) async*{
  int valueLoader = 0;
  
  // * un stream que cambiara el valor de una property cada cierto tiempo
  // ? usamos yield* para que este emitiendo valores constantemente hasta el autodispose
  yield* Stream.periodic( 
    const Duration(milliseconds: 350),
    (int value) {
      valueLoader = value++;
      return valueLoader; // * emitir el dato (cada que emite un nuevo dato redibuja)
    }, // ? value que se estara emitiendo cada 250 miliseconds
  );

});
