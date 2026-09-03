import 'package:shared_preferences/shared_preferences.dart';

import 'chat_id_value_storage_service.dart';

class ChatIdValueStorageServiceImpl extends ChatIdValueStorageService {

  // ? instancia de shared preferences
  Future<SharedPreferences> getInstancePreferences() async{
    return await SharedPreferences.getInstance();
  }

  @override
  Future<String> getValueChatId(String key) async{
    final prefs = await getInstancePreferences();

    return prefs.getString(key) ?? ''; 
  }

  @override
  Future<void> setValueChatId(String chatId, String key) async{
    final prefs = await getInstancePreferences();

    await prefs.setString(key, chatId);
  }
  
}