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
final chatWithContextProvider = StateNotifierProvider<ChatWithContextNotifier, ChatWithContextState>((ref) {

  final veloraRepository = ref.watch(veloraRepositoryProvider);
  final veloraUser = ref.read(userVeloraProvider);

  return ChatWithContextNotifier( ref: ref, veloraRepository: veloraRepository, veloraUser: veloraUser );
});

// ! NOTIFIER
class ChatWithContextNotifier extends StateNotifier<ChatWithContextState> {

  final VeloraRepositoryImpl veloraRepository;
  final User veloraUser;
  final Ref ref;

  ChatWithContextNotifier({
    required this.ref, 
    required this.veloraRepository, 
    required this.veloraUser
  }): super(ChatWithContextState()) {
    loadMessagesByChatId();
  }

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

    // * segun el valor inicializado de uuid, ese lo mandaremos hacia nuestro backend para 
    // * que si no existe aun, cree un nuevo chat con ese uuid y alamacene la nueva list de messages
    // ! (en este punto siempre existira un uuid pq al momento de necesitar este provider
    // ! ejecutamos loadmessages method y ese metodo inicializa si o si un uuid )
    final chatId = ref.watch(currentIdChatProvider).chatId;
    
    // ? se manda un chatid ya inicializado previamente para que no sobreescriba otro
    // ? con ese id en el backend buscara en la property correspondiente con ese uuid
    // ? y agregara este message que mandamos
    // * escuchar las emisiones, mandar el prompt y las images
    veloraRepository.getChatStreamResponse(prompt, chatId, files: images).listen(
      (chunk){
        if(chunk.isEmpty) return;
        
        // * tomar la list (con todos los messages anteriores)
        // ? es obtener el state anteior sin el 'Velora esta pensando....'
        final updatedMessages = [...state.messagesFiles];
        // * actualizar el ultimo message con la emision del ultimo chunk
        // * AQUI USAMOS EL MENSAJE QUE AGREGAMOS DE VELORA ESTA ESCRIBIENDO....
        // * LO USAMOS ES EL FIRST Y LO CAMBIAMOS A LA RESPONSE DE VELORA EMITIDA POR CHUNKS
        // ! LO ESTAMOS SOBREESCRIBIENDO
        final updatedMessage = (updatedMessages.first as TextMessage).copyWith(
          text: chunk,
        );

        // ! aqui quitamos el esta esta escribiendo....
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

  
  // * METODO QUE CARGA LOS MESSAGES SEGUN UN UUID
  Future<bool> loadMessagesByChatId() async{

    // ? uuid
    final chatId = await ref.watch(currentIdChatProvider.notifier).getChatIdValueLocalStorage();

    // ? si el uuid que obtuvimos es empty o nada, lo que hacemos es inicializar un uuid
    if (chatId.isEmpty || chatId == '') {
      ref.read(currentIdChatProvider.notifier).setChatId(chatId);
    }

    // ? obtenemos los messages segun ese uuid ( puede ser un array vacio si no existe
    // ? chat history con ese uuid )
    final messagesById = await veloraRepository.getMessagesChatById(chatId);

    // ? usuario principal
    final userPrincipal = ref.read(userPrincipalProvider.notifier).state;

    // ? list of messages for insert
    final messageToInto = messagesById.map(
      (message){
      if (message.rol == 'user') {
        return TextMessage(
          author: userPrincipal, 
          id: _uuid.v4(), 
          text: message.mesage
        );
      }else{
        return TextMessage(
          author: veloraUser, 
          id: _uuid.v4(), 
          text: message.mesage
        );
      }
    }).toList();

    // ? retrasar el cambio de state y el retorno del value 1 seg
    await Future.delayed(const Duration(seconds: 2));

    // ? cambiamos el state con la lista recuperada
    state = state.copyWith(
      messagesFiles: messageToInto.reversed.toList()
    );

    return true;

  }

  // * metodo que elimina los anteriores messages y crea un 
  //* nuevo uuid (nuevo object con su context chat)
  void newChat() async{
    // ? nuevo uuid
    ref.read(currentIdChatProvider.notifier).setChatId(_uuid.v4());

    state = state.copyWith(
      messagesFiles: const[]
    );
  }

}

// ! STATE
class ChatWithContextState {
  final List<Message> messagesFiles;

  ChatWithContextState({
    this.messagesFiles = const[],
  });


  ChatWithContextState copyWith({
    List<Message>? messagesFiles,
  }) => ChatWithContextState(
      messagesFiles: messagesFiles ?? this.messagesFiles,
  );

}