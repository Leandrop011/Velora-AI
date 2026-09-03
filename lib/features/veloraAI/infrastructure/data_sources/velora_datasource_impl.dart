
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_app/features/veloraAI/infrastructure/models/messages_response.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

import '../../domain/data_sources/velora_datasource.dart';
import '../../domain/entities/entities.dart';

class VeloraDatasourceImpl extends VeloraDatasource{
  
  // ? base endpoint from .env
  final _dio = Dio( 
    BaseOptions(
      baseUrl: dotenv.env['ENDPOINT_API'] ?? ''
    ),
  );
  
  // ! METODO QUE OBTIENE UNA RESPONSE INMEDIATA DE VELORA EN TEXTO PLANO 
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
  
  // ! METODO QUE OBTIENE UNA RESPUESTA DE VELORA EN TEXTO PLANTO PERO EN FORMATO STREAM
  // ! ESTE METODO TAMBIEN PUEDE MANDAR FILES
  @override
  Stream<String> getStreamResponse(String prompt, {List<XFile> files = const[]}) async*{
    try {

      // ! USAR EL METODO DE EMITIR UNA RESPONSE
      // ! SEGUN SUS ARGUMENTOS
      // ? se usa yiel* pq estamos escuchando un stream dentro de un stream
      yield* _getStreamResponse(
        endpoint: '/basic-prompt-stream',
        files: files,
        prompt: prompt,
      );

    } catch (e) {
      yield "Can't get Velora response, please try again later.";
    }
  }

  // ! METODO QUE PUEDE OBTENER UNA RESPONSE DE VELORA EN BASE A UN CHAT REFERENCIADO
  // ! CON UN ID UNICO, DE IGUAL MANERA PUEDE MANDAR FILES
  @override
  Stream<String> getChatStreamResponse(
    String prompt, 
    String chatId, 
    {List<XFile> files = const []}
  ) async*{
    try {

      // ! USAMOS EL METODO PRIVADO QUE EMITIRA RESPUESTAS
      // ! EN BASE A LOS ARGUMENTOS QUE LE DEMOS
      // ? SE USA YIELD* PQ ESCUCHAREMOS UN STREAM DENTRO DE UN STREAM
      yield* _getStreamResponse(
        endpoint: '/chat-stream',
        files: files,
        prompt: prompt,
        formFields: Map.fromEntries(
          {
            MapEntry('chatId', chatId),
          },
        )
      );

    } catch (e) {
      yield "Can't get Velora response, please try again later.";
    }
  }


  // ! METODO QUE DEVUELVE UN LISTADO DE MESSAGES SEGUN UN ID DE LA CONVERSACION
  @override
  Future<List<Message>> getMessagesChatById(String chatId) async{
    try {
      
      final response = await _dio.get(
        '/chat-history/$chatId'
      );

      // * tratamos la data como una list y luego iteramos cada elemento
      // * cada elemento lo transformamos al model del message ( un model de como viene la data del backend )
      // * y luego ese model regresamos una instancia de nuestra entity con cada propiedad
      final messages = (response.data as List).map( 
        (element) {
          // ? model de como viene del backend
          final model = MessagesResponse.fromJson(element as Map<String, dynamic>);

          return Message(
            rol: model.role, 
            mesage: model.parts,
          );
        }
      ).toList();

      return messages;

    } catch (e) {
      return [];
    }
  }


  // ! METODO QUE EMITA LA RESPUESTA (STREAM)
  Stream<String> _getStreamResponse({
    required String endpoint,
    required String prompt,
    List<XFile> files = const [],
    Map<String, dynamic> formFields = const{}
  }) async*{

    // * formdata
    final formData = FormData();

    // * siempre agregamos el stream
    formData.fields.add(MapEntry('prompt', prompt));
    // * reciviremos un map (seran el prompt y posiblemente el chatid)
    // * y aqui lo agregamos al formdata(lo que mandaremos al backend)
    for (var entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }
      
    // * enviar files
    if(files.isNotEmpty){ // ? images, iteration everyone
      for (final file in files) {
        formData.files.add( 
          MapEntry(
            'files', 
            await MultipartFile.fromFile(file.path, filename: file.name) // ? add a image format 
          ) 
        );
      }
    }
    
    // * response
    final response = await _dio.post(
      endpoint,
      data: formData, // ? form data
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

  } 
  
}

