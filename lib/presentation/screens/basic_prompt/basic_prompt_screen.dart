import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/chat/basic_chat.dart';
import 'package:gemini_app/presentation/providers/providers.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final geminiUser = ref.watch(userGeminiProvider);
    final userPrincipal = ref.watch(userPrincipalProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatMessages = ref.watch(basicChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Basico'),
      ),

      // ? WIGET DE CHAT UI
      body: Expanded(
        child: Chat(
          // * MENSAJES
          messages: chatMessages.messages,
        
          // * METODO ONPRESSED 
          onSendPressed: ( types.PartialText partialText ) {
            ref.read(basicChatProvider.notifier).addMessage(userPrincipal, partialText);
          }, 
          
          // * USUARIO
          user: userPrincipal,
          // * TEMA 
          theme: DarkChatTheme(),
        
          showUserNames: true,
          
          // * INDICADOR DE 'ESCRIBIENDO...'
          typingIndicatorOptions: TypingIndicatorOptions(
            // ? Indicar quien esta escribiendo(User)
            typingUsers: (isGeminiWriting.isWriting) ? [ geminiUser ] : [],
            // customTypingIndicator: Text('Gemini escribiendo....'),
          ),
        
        ),
      ),
    );
  }
}