import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class ThemeValueStorageServiceImpl extends ThemeValueStorageService {
  
  // * INSTANCIA DE SHARED PREFERENCES
  Future<SharedPreferences> getInstance() async{
    return await SharedPreferences.getInstance();
  }
  
  @override
  Future<int> getThemeValue(String key) async{
    final prefs = await getInstance();
    return prefs.getInt(key) ?? 0;
  }

  @override
  Future<void> setThemeValue(String key, int value) async{
    final prefs = await getInstance();
    await prefs.setInt(key, value);
  }
  
}
