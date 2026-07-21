import 'package:riverpod/legacy.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

// ! PROVIDER
final isGeminiWritingProvider = StateNotifierProvider.autoDispose<IsGeminiWritingNotifier, IsGeminiWriting>((ref) {
  return IsGeminiWritingNotifier();
});

// ! NOTIFIER
class IsGeminiWritingNotifier extends StateNotifier<IsGeminiWriting> {
  IsGeminiWritingNotifier(): super(IsGeminiWriting());
  
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
class IsGeminiWriting {
  
  final bool isWriting;

  IsGeminiWriting({
    this.isWriting = false,
  });


  IsGeminiWriting copyWith({
    bool? isWriting,
  }) => IsGeminiWriting(
      isWriting: isWriting ?? this.isWriting,
  );
  
}

