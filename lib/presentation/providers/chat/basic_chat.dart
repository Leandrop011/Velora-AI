// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

// ? SOLO LA INSTANCIA SIN V4 PORQUE SI SE HACE ESO SERA UN ID MISMO PARA TODOS Y ESO DA ERROR
const _uuid = Uuid();

// ! PROVIDER
final basicChatProvider = StateNotifierProvider.autoDispose<BasicChatNotifier, BasicChatState>((ref) {
  return BasicChatNotifier( ref: ref );
});
// ! NOTIFIER
class BasicChatNotifier extends StateNotifier<BasicChatState> {

  final Ref ref;

  BasicChatNotifier({required this.ref}): super(BasicChatState());

  // ? METODO QUE DEFINIRA QUE TIPO DE MENSAJE SE AGREGA
  void addMessage(User user, PartialText partialText){

    _addTextMessage(user, partialText);
  }

  // ? METODO QUE AGREGAR UN MENSAJE DE TEXTO, partialtext es el mensaje que el input tiene cuando send
  void _addTextMessage( User author, PartialText partialText ){
    // * New message 
    final newMessage = TextMessage(
      author: author, 
      id: _uuid.v4(), 
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch
    );

    state = state.copyWith(
      // * PRIMERO AGREGA EL MNENSAJE Y CONSERVA LOS ANTERIORES
      messages: [newMessage, ...state.messages]
    );

    _geminiTextResponse(partialText.text);
  }

  // ? METODO QUE AGREGA LOS MENSAJES DE GEMINI AL STATE, EL PROMPT SERA EL QUE SEGUN ESO RESPONDE GEMINI
  void _geminiTextResponse(String prompt) async{

    // * USUARIO DE GEMINI
    final geminiUser = ref.read(userGeminiProvider);

    // * COLOCAMOS EN ESCRIBIENDO...
    ref.read(isGeminiWritingProvider.notifier).setIsWriting();

    // * DELAYED DE 2 SEGUNDOS
    await Future.delayed(Duration(seconds: 2));

    // * COLOCAMOS EN NO ESCRIBIENDO
    ref.read(isGeminiWritingProvider.notifier).setIsNotWriting();

    // * CREAMOS UN NUEVO MENSAJE
    final newMessage = TextMessage(
      author: geminiUser, 
      id: _uuid.v4(), 
      text: 'Buen mensaje, tu prompt fue: $prompt',
      createdAt: DateTime.now().millisecondsSinceEpoch
    );

    // * Y LO AGREGAMOS AL STATE
    state = state.copyWith(
      // * PRIMERO AGREGA EL MNENSAJE Y CONSERVA LOS ANTERIORES
      messages: [newMessage, ...state.messages]
    );

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
