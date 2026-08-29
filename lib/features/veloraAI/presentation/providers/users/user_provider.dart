import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:riverpod/legacy.dart';

// ! PROVIDERS DE EL USUARIO Y EL USER GEMINI
final userVeloraProvider = StateProvider.autoDispose<types.User>((ref) {
    return const types.User(
      id: 'user-gemini',
      firstName: 'Velora',
      imageUrl: 'https://picsum.photos/id/177/200/200',
    );
});

final userPrincipalProvider = StateProvider.autoDispose<types.User>((ref) {
  return const types.User(
    id: 'user-principal',
    firstName: 'Leandro',
    lastName: 'Pozo',
    imageUrl: 'assets/avatar/velora-avatar-01.png',
  );

});