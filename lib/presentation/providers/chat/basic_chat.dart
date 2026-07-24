import 'package:riverpod/legacy.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../../infrastructure/infrastructure.dart';
import '../providers.dart';

// ? constante de uuid
const _uuid = Uuid();

// ! PROVIDER
final basicChatProvider = StateNotifierProvider<BasicChatNotifier, BasicChatState>((ref) {

  final veloraRepository = ref.watch(veloraRepositoryProvider);
  final veloraUser = ref.read(userVeloraProvider);

  return BasicChatNotifier( ref: ref, veloraRepository: veloraRepository, veloraUser: veloraUser );
});

// ! NOTIFIER
class BasicChatNotifier extends StateNotifier<BasicChatState> {

  final VeloraRepositoryImpl veloraRepository;
  final User veloraUser;
  final Ref ref;

  BasicChatNotifier({
    required this.ref, 
    required this.veloraRepository, 
    required this.veloraUser
  }): super(BasicChatState());

  // ? METODO QUE DEFINIRA QUE TIPO DE MENSAJE SE AGREGA
  void addMessage(User user, PartialText partialText){
    _addTextMessage(user, partialText);
  }

  // ? METODO QUE AGREGAR UN MENSAJE DE TEXTO, partialtext es el mensaje que el input tiene cuando se envia
  void _addTextMessage( User author, PartialText partialText ){
    // * New message 
    _createTextMessage(author, partialText.text);
    // * respuesta de velora
    _veloraTextResponseStream(partialText.text);
  }

  // ? METODO QUE AGREGA LOS MENSAJES DE GEMINI AL STATE, EL PROMPT SERA EL QUE SEGUN ESO RESPONDE GEMINI
  void _veloraTextResponse(String prompt) async{

    // * COLOCAMOS EN ESCRIBIENDO
    _setVeloraWritingStatus(true);

    // * CONSULTA AL REPOSITORY
    final responseGemini = await veloraRepository.getResponse(prompt);

    // * COLOCAMOS EN NO ESCRIBIENDO
    _setVeloraWritingStatus(false);

    // * CREAMOS UN NUEVO MENSAJE
    _createTextMessage(veloraUser, responseGemini);

  }

  // ? METO QUE EMITE VALORES DE UN STREAMM EN LUGAR DE UN RESPUESTA INSTANTANEA
  void _veloraTextResponseStream(String prompt) async{
    
    _createTextMessage(veloraUser, 'Velora esta pensando....');

    // * escuchar las emisiones
    veloraRepository.getStreamResponse(prompt).listen(
      (chunk){
        if(chunk.isEmpty) return;
        
        // * tomar la list
        final updatedMessages = [...state.messages];
        // * actualizar el ultimo message con la emision del ultimo chunk
        final updatedMessage = (updatedMessages.first as TextMessage).copyWith(
          text: chunk,
        );

        // * aztualizamos la posicion 1 de la list con ese mssaga
        // * esto se realiza para que no de esa impresion de cada que actualiza el state
        // * de ese efecto de rebote
        updatedMessages[0] = updatedMessage;

        // * actualizamos el state
        state = state.copyWith(
          messages: updatedMessages,
        );

      }
    );
  
  }


  // ? HELPER METHODS
  // * metodo que coloca el state del iswriting en true or false
  void _setVeloraWritingStatus(bool isWriting){
    final isVeloraWriting = ref.read(isVeloraWritingProvider.notifier);
    isWriting ? 
      isVeloraWriting.setIsWriting() 
      : 
      isVeloraWriting.setIsNotWriting();
  }

  // * metodo que crea un nuevo message y lo agregar al state
  void _createTextMessage( User author, String text ){
    final newMessage = TextMessage(
      author: author, 
      id: _uuid.v4(), 
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch
    );

    state = state.copyWith( messages: [newMessage, ...state.messages] );
  }
  
}
// ! STATE
class BasicChatState {
  final List<Message> messages;

  BasicChatState({
    this.messages = const[],
  });


  BasicChatState copyWith({
    List<Message>? messages,
  }) => BasicChatState(
      messages: messages ?? this.messages,
  );

}
