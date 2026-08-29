import 'package:gemini_app/features/shared/shared.dart';
import 'package:riverpod/legacy.dart';

// * const for save in local storage
const _keyStorageValue = 'key-storage-value';

// ! PROVIDER
final appThemeValueProvider = StateNotifierProvider.autoDispose<AppThemeValueNotifier, AppThemeValueState>((ref) {
  
  final ThemeValueStorageServiceImpl themeValueStorageServiceImpl = ThemeValueStorageServiceImpl();

  return AppThemeValueNotifier( themeValueStorageService: themeValueStorageServiceImpl );
});
// ! NOTIFIER

class AppThemeValueNotifier extends StateNotifier<AppThemeValueState> {
  
  final ThemeValueStorageService themeValueStorageService;
  
  AppThemeValueNotifier({
    required this.themeValueStorageService
  }): super(AppThemeValueState()){
    _getValueThemeInStorage();
  }

  // * metodo que obtiene el theme value from local storage
  void _getValueThemeInStorage() async{
    final valueThemeStorage = await themeValueStorageService.getThemeValue(_keyStorageValue);

    state = state.copyWith(
      value: valueThemeStorage,
    );

  }

  // * metodo que establece el value theme in local storage
  void _setValueInStorage(int value) async{
    await themeValueStorageService.setThemeValue(_keyStorageValue, value);
  }
  
  // * metodo que cambia el valuetheme
  void changeThemeValue( int value ){

    _setValueInStorage(value);

    state = state.copyWith(
      value: value,
    );
  }

}

// ! STATE
class AppThemeValueState {
  final int value;

  AppThemeValueState({
    this.value = 0,
  });

  AppThemeValueState copyWith({
    int? value,
  }) => AppThemeValueState(
    value: value ?? this.value,
  );
  
}
