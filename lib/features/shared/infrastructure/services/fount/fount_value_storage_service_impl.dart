import 'package:shared_preferences/shared_preferences.dart';

import 'fount.dart';

class FountValueStorageServiceImpl extends FountValueStorageService {
  
  Future<SharedPreferences> getInstance() async{
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> getValueFount(String key) async{
    final prefs = await getInstance();

    return prefs.getBool(key) ?? true;
  }

  @override
  Future<void> setValueFount(String key, bool value) async{
    final prefs = await getInstance();

    await prefs.setBool(key, value);
  }
  
}
