
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:gemini_app/domain/data_sources/velora_datasource.dart';

class VeloraDatasourceImpl extends VeloraDatasource{
  
  final _dio = Dio( 
    BaseOptions(
      baseUrl: dotenv.env['ENDPOINT_API'] ?? ''
    ),
  );
  
  @override
  Future<String> getResponse(String prompt) async{
    try {
      // ? convertir la data que enviaremos de map a json
      final body = jsonEncode(
        {'prompt': prompt}
      );

      // ? al path que deseamos llegar es al /basic-prompt
      final response = await _dio.post( 
        '/basic-prompt', 
        data: body,
      );
      return response.data.toString();
    } catch (e) {
      return 'Cant get Velora response, please try again later.';
    }

  }
  
  @override
  Stream<String> getStreamResponse(String prompt) async*{
    try {

      final body = jsonEncode( {'prompt': prompt} );
      
      final response = await _dio.post(
        '/basic-prompt-stream',
        data: body,
        options: Options( // * el tipo de response que nos dara la peticion
          responseType: ResponseType.stream,
        )
      );
      
      // * definir el stream( list int porque de esa forma viene la info, y en la que procesamos )
      final stream = response.data.stream as Stream<List<int>>;

      // * variable buffer, que ira concatenadose con los chunks
      String buffer = '';

      // * emitir valores del stream
      await for ( final chunk in stream ){
        // * 'decodificar' el chunk( esto es por siacaso nos regresa un caracter que no se procesa )
        final chunkString = utf8.decode(chunk, allowMalformed: true);

        // * concatenar al buffer el chunk
        buffer = buffer + chunkString;

        // * emitir valores
        yield buffer;
      }

    } catch (e) {
      yield "Can't get Velora response, please try again later.";
    }
  }
  
}

