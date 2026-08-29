import 'package:gemini_app/features/shared/shared.dart';
import 'package:riverpod/legacy.dart';

// ? CONST FOR SAVE IN LOCALSTORAGE
const _keyFountValueStorage = 'key-fount-value-storage';

// ! PROVIDER
final appFountValueProvider = StateNotifierProvider.autoDispose<AppFountValueNotifier, AppFountValueState>((ref) {
  
  final FountValueStorageServiceImpl fountValueStorageServiceImpl = FountValueStorageServiceImpl();
  
  return AppFountValueNotifier( fountValueStorageService: fountValueStorageServiceImpl );
});

// ! NOTIFIER
class AppFountValueNotifier extends StateNotifier<AppFountValueState> {

  final FountValueStorageService fountValueStorageService;

  AppFountValueNotifier({
    required this.fountValueStorageService
  }): super(AppFountValueState()){
    _getFountValueInStorage();
  }

  // * metodo que obtendra el fount value from local storage
  void _getFountValueInStorage() async{
    final fountValueStorage = await fountValueStorageService.getValueFount(_keyFountValueStorage);

    state = state.copyWith(
      value: fountValueStorage,
    );
  }
  // * metodo que establecera el fount value in local storage
  void _setFountValueInStorage( bool value ) async{
    await fountValueStorageService.setValueFount(_keyFountValueStorage, value);
  }
  // * metodo que cambiara el state de la property fount value y ademas la guardara localmente
  void changeFountValue( bool value ){
    _setFountValueInStorage(value);

    state = state.copyWith(
      value: value,
    );
  }
  
}

// ! STATE
class AppFountValueState {
  final bool value;

  AppFountValueState({
    this.value = true,
  });

  AppFountValueState copyWith({
    bool? value,
  }) => AppFountValueState(
      value: value ?? this.value,
  );
  
}
