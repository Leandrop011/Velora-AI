import 'package:riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

import 'package:gemini_app/features/shared/shared.dart';

// ! PROVIDER QUE MANEJARA EL CHAT ID ACTUAL
// ? const uuid
const _uuid = Uuid();
const _keyToChatIdValueStorage = 'chat-id-storage';

// ! PROVIDER
final currentIdChatProvider = StateNotifierProvider.autoDispose<CurrentIdChatNotifier, CurrentIdChatState>((ref) {
  final ChatIdValueStorageServiceImpl chatIdValueStorageServiceImpl = ChatIdValueStorageServiceImpl();
  return CurrentIdChatNotifier( chatIdValueStorageService: chatIdValueStorageServiceImpl );
});
// ! NOTIFIER
class CurrentIdChatNotifier extends StateNotifier<CurrentIdChatState> {

  final ChatIdValueStorageService chatIdValueStorageService;

  CurrentIdChatNotifier({
    required this.chatIdValueStorageService
  }): super(CurrentIdChatState()){
    getChatIdValueLocalStorage();
  }
  
  // * metodo para obtener el uuid del local storage
  Future<String> getChatIdValueLocalStorage() async{
    
    final value = await chatIdValueStorageService.getValueChatId(_keyToChatIdValueStorage);

    state = state.copyWith(
      chatId: value,
    );

    return value;
  }

  // * metodo para guardar un uuid en local storage
  void _setChatIdValueLocalStorage( String chatId ) async{
    await chatIdValueStorageService.setValueChatId(chatId, _keyToChatIdValueStorage);
  }

  // * metodo para establecer un uuid
  void setChatId( String chatId ){

    if (chatId.isEmpty || chatId == '') {
      final chatIdNotEmpty = _uuid.v4();
      _setChatIdValueLocalStorage(chatIdNotEmpty);
      state = state.copyWith( chatId: chatIdNotEmpty );
      return;
    }

    _setChatIdValueLocalStorage(chatId);
    state = state.copyWith(
      chatId: chatId,
    );
  }
}

// ! STATE
class CurrentIdChatState {
  final String chatId;

  CurrentIdChatState({
    this.chatId = '',
  });

  CurrentIdChatState copyWith({
    String? chatId,
  }) => CurrentIdChatState(
    chatId: chatId ?? this.chatId,
  );
  
}

