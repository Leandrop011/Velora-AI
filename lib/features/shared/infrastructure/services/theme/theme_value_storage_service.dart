
abstract class ThemeValueStorageService {
  Future<int> getThemeValue(String key);
  Future<void> setThemeValue(String key, int value);
}
