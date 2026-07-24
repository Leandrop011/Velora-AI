import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/presentation/providers/providers.dart';
import 'package:gemini_app/presentation/widgets/shared/shared.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final veloraUser = ref.watch(userVeloraProvider);
    final userPrincipal = ref.watch(userPrincipalProvider);
    final isVeloraWriting = ref.watch(isVeloraWritingProvider);
    final chatMessages = ref.watch(basicChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Velora Chat Basico', style: textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => CustomShowDialog().infoMake(
              context, 
              'Informacion', 
              'Esta es una conversacion basica con Velora, la cual no tiene memoria, por lo que no recordara nada de lo que se hable en esta conversacion, por ende tus consumos seran mas bajos.', 
              [
                FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ), 
                  child: const Text('Ok'),
                )
              ], 
              textTheme,
            ), 
            icon: const Icon(Icons.info_rounded),
          ),
        ],
      
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
          theme: const DarkChatTheme(),
        
          showUserNames: true,

          // * OPCIONES DE LOS INGRESOS
          inputOptions: const InputOptions(
            autocorrect: true,
          ),

          // * CONSTRUCCION DEL AVATAR
          avatarBuilder: (_){
          // * NAVEGACION HACIA LA INFO DE VELORA
            return GestureDetector(
              onTap: () => context.push('info-velora'),
              child: AvatarBoxWidget(
                size: size, 
                image: 'assets/avatar/velora-avatar-01.png'
              ),
            );
          },
          showUserAvatars: true,

          // * INDICADOR DE 'ESCRIBIENDO...'
          typingIndicatorOptions: TypingIndicatorOptions(
            // ? Indicar quien esta escribiendo, true: velora, false user o nadie
            typingUsers: (isVeloraWriting.isWriting) ? [ veloraUser ] : [],
            // customTypingIndicator: Text('Velora escribiendo....'),
          ),
        
        ),
      ),
    );
  }
}