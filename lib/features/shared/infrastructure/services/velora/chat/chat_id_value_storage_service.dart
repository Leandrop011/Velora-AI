
abstract class ChatIdValueStorageService {
  Future<void> setValueChatId(String chatId, String key);
  Future<String> getValueChatId(String key);
}
