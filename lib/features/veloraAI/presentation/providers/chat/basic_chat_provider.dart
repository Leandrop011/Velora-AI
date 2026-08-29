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

  // ? METODO QUE AGREGA UN NUEVO MESSAGE
  void addMessage(
    User author, 
    PartialText partialText, 
  ){
    _addTextMessage(author, partialText);
  }

  // ? METODO QUE AGREGAR UN MENSAJE DE TEXTO, partialtext es el mensaje que el input tiene cuando se envia
  void _addTextMessage( User author, PartialText partialText ){
    // * New message 
    _createTextMessage(author, partialText.text);
    // * respuesta de velora
    _veloraTextResponse(partialText.text);
  }

  // ? METODO QUE AGREGA LOS MENSAJES DE GEMINI AL STATE, EL PROMPT SERA EL QUE SEGUN ESO RESPONDE GEMINI
  void _veloraTextResponse(String prompt) async{

    // * state messages
    final updatedMessage = [...state.messages]; 

    _createTextMessage(veloraUser, 'Velora esta pensando...');

    // * CONSULTA AL REPOSITORY
    final responseGemini = await veloraRepository.getResponse(prompt);

    // * colocamos el estado anterior, cuando aun no se agrego el 'Velora esta pensando...'
    // * para manejar el state sin esos messages
    state = state.copyWith(
      messages: updatedMessage,
    );

    // * CREAMOS UN NUEVO MENSAJE
    _createTextMessage(veloraUser, responseGemini);

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

    // ? se agrega al state el nuevo message y se hace el spred de los anteriores
    // ? incluyendo el de velora y el user
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
