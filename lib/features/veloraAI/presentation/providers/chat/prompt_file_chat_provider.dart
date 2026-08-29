import 'package:riverpod/legacy.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../../infrastructure/infrastructure.dart';
import '../providers.dart';

// ? constante de uuid
const _uuid = Uuid();

// ! PROVIDER
final promptFileChatProvider = StateNotifierProvider<PromptFileChatNotifier, PromptFileChatState>((ref) {

  final veloraRepository = ref.watch(veloraRepositoryProvider);
  final veloraUser = ref.read(userVeloraProvider);

  return PromptFileChatNotifier( ref: ref, veloraRepository: veloraRepository, veloraUser: veloraUser );
});

// ! NOTIFIER
class PromptFileChatNotifier extends StateNotifier<PromptFileChatState> {

  final VeloraRepositoryImpl veloraRepository;
  final User veloraUser;
  final Ref ref;

  PromptFileChatNotifier({
    required this.ref, 
    required this.veloraRepository, 
    required this.veloraUser
  }): super(PromptFileChatState());

  // ? METODO QUE DEFINIRA QUE TIPO DE MENSAJE SE AGREGA
  void addMessage(
    User author, 
    PartialText partialText, 
    {List<XFile> images = const[]}
  ){

    // * case when user provider images
    if( images.isNotEmpty ){
      _addTextMessageWithImages(partialText, author, images);
      return;
    }

    _addTextMessage(author, partialText);
  }

  // ? METODO QUE AGREGAR UN MENSAJE DE TEXTO, partialtext es el mensaje que el input tiene cuando se envia
  void _addTextMessage( User author, PartialText partialText ){
    // * New message 
    _createTextMessage(author, partialText.text);
    // * respuesta de velora
    _veloraTextResponseStream(partialText.text);
  }

  
  // ? METODO QUE CREARA UN NUEVO MESSAGE CON TEXTO E IMAGENES AGREGANDO LA RESPUESTA DE VELORA
  void _addTextMessageWithImages( 
    PartialText partialText, 
    User author, 
    List<XFile> images 
  ) async{

    // * creacion de las images para mostrar en chat y manejar su state
    for (XFile image in images) {
      _createImageMessage(author, image);
    } 

    // ? un pequeno delayed para esperar que primero se construyan las imagenes 
    // ? y luego el message user
    await Future.delayed(const Duration(milliseconds: 5));

    // * creacion del message
    _createTextMessage(author, partialText.text);

    // * response of velora
    _veloraTextResponseStream(partialText.text, images: images);
  }
  
  // ? METODO QUE EMITE VALORES DE UN STREAM EN LUGAR DE UN RESPUESTA INSTANTANEA
  void _veloraTextResponseStream(String prompt, {List<XFile> images = const[]}) async{
    
    _createTextMessage(veloraUser, 'Velora esta pensando....');

    // * escuchar las emisiones, mandar el prompt y las images
    veloraRepository.getStreamResponse(prompt, files: images).listen(
      (chunk){
        if(chunk.isEmpty) return;
        
        // * tomar la list (con todos los messages anteriores)
        // ? es obtener el state anteior sin el 'Velora esta pensando....'
        final updatedMessages = [...state.messagesFiles];
        // * actualizar el ultimo message con la emision del ultimo chunk
        final updatedMessage = (updatedMessages.first as TextMessage).copyWith(
          text: chunk,
        );

        // * aztualizamos la posicion 1 de la list con ese mssaga
        // * esto se realiza para que no de esa impresion de cada que actualiza el state
        // * de ese efecto de rebote
        // ? POR ESO DESDE LA POSICION 0 DE LA LIST
        updatedMessages[0] = updatedMessage;

        // * actualizamos el state
        // ? CON EL updatedMessages( YA ACTUALIZADA SU POSICON 0 CON LAS EMISIONES CONSECUTIVAS DEL STREAM )
        // ? SIEMPRE SOBREESCRIBIENDOSE
        // ! agrega un nuevo message (respuesta de velora), con la var updatedMessages
        // ! ya conserva todos los mesages anteriores y cuando actualiza el state agrega un nuevo 
        // ! message de primero(posicion 0) con la respuesta de velora
        // ! y ahora hacemos un cambio de estado con esa nueva list(agrego la response de velora y los
        // ! anteriores messages)  
        state = state.copyWith(
          messagesFiles: updatedMessages,
        );

      }
    );
  
  }

  // * metodo que crea un nuevo message y lo agregar al state
  void _createTextMessage( User author, String text ){
    final newMessage = TextMessage(
      author: author, 
      id: _uuid.v4(), 
      text: text, 
      createdAt: DateTime.now().millisecondsSinceEpoch
    );

    // ? se agrega al state el nuevo message y se hace el spred de los anteriores
    // ? incluyendo el de velora y el user
    state = state.copyWith( messagesFiles: [newMessage, ...state.messagesFiles] );
  }
  
  // * metodo que crea un image message y lo agrega al state
  void _createImageMessage( User author, XFile image ) async{
    
    // * crear image
    final newImage = ImageMessage(
      id: _uuid.v4(), 
      author: author, 
      name: image.name, // ? name of image from local 
      uri: image.path, // ? uri image
      size: await image.length(), // ? size image
    );

    // * agregar al state y conservar lo anterior
    state = state.copyWith( messagesFiles: [newImage, ...state.messagesFiles] );
  }

}
// ! STATE
class PromptFileChatState {
  final List<Message> messagesFiles;

  PromptFileChatState({
    this.messagesFiles = const[],
  });


  PromptFileChatState copyWith({
    List<Message>? messagesFiles,
  }) => PromptFileChatState(
      messagesFiles: messagesFiles ?? this.messagesFiles,
  );

}
