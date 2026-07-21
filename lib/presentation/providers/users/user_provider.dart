import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:riverpod/legacy.dart';

// ! PROVIDERS DE EL USUARIO Y EL USER GEMINI
final userGeminiProvider = StateProvider.autoDispose<types.User>((ref) {
    return types.User(
      id: 'user-gemini',
      firstName: 'Gemini',
      imageUrl: 'https://picsum.photos/id/177/200/200',
    );
});

final userPrincipalProvider = StateProvider.autoDispose<types.User>((ref) {
  
  return types.User(
    id: 'user-principal',
    firstName: 'Leandro',
    lastName: 'Pozo',
    imageUrl: 'https://picsum.photos/id/177/200/200',
  );

});


// ! FORMA DE ESCRIBIR RIVERPOD PERO CON EL GENERADOR DE CODIGO
// part 'user_provider.g.dart';

// // ? FUNCION PROVIDER DE RIVERPOD, ES NECESARIO EL ARCHIVO G PARA USAR LA FUNCION COMO UN PROVIDER DE RIVERPOD
// @riverpod
// types.User geminiUser( Ref ref ){
//   final geminiUser = types.User(
//     id: 'user-gemini',
//     firstName: 'Gemini',
//     imageUrl: 'https://picsum.photos/id/177/200/200',
//   );

//   return geminiUser;
// }