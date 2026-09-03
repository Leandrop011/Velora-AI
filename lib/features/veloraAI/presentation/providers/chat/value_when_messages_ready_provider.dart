
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';

// ! CREAMOS ESTE PROVIDER CON EL OBJETIVO DE RESOLVER EL FUTURE BOOL DEL METODO 
// ! loadMessagesByChatId EN EL NOTIFIER DEL PROVIDER chatWithContextProvider Y ASI 
// ! DEVOLVER EL VALUE A NUESTRO WIDGET Y EN ESE MOMENTO USAR .WHEN
// ? sin autodispose para que no vuelva a redibujar el loading cuando ya tenga el value
// ? ( el provider de messages tambien no tiene el autodispose )
final valueWhenMessagesReadyProvider = FutureProvider<bool>((ref) async {
  final isReadyMessages = await ref.watch(chatWithContextProvider.notifier).loadMessagesByChatId();

  return isReadyMessages;
});
