import 'package:riverpod/legacy.dart';

// ! PROVIDER
final isVeloraWritingProvider = StateNotifierProvider.autoDispose<IsVeloraWritingNotifier, IsVeloraWriting>((ref) {
  return IsVeloraWritingNotifier();
});

// ! NOTIFIER
class IsVeloraWritingNotifier extends StateNotifier<IsVeloraWriting> {
  IsVeloraWritingNotifier(): super(IsVeloraWriting());
  
  // * Metodos para establecer si escribe o no
  void setIsWriting(){
    state = state.copyWith(
      isWriting: true,
    );
  }

  void setIsNotWriting(){
    state = state.copyWith(
      isWriting: false,
    );
  }

}

// ! PROVIDER
class IsVeloraWriting {
  
  final bool isWriting;

  IsVeloraWriting({
    this.isWriting = false,
  });


  IsVeloraWriting copyWith({
    bool? isWriting,
  }) => IsVeloraWriting(
      isWriting: isWriting ?? this.isWriting,
  );
  
}

