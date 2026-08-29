import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;

    final userPrincipal = ref.watch(userPrincipalProvider);
    final chatMessages = ref.watch(basicChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Velora Chat Basico', 
          style: textTheme.titleLarge?.copyWith(
            shadows: [
              Shadow(
                blurRadius: 10,
                color: colorTheme.primary,
                offset: const Offset(2, 2),
              )
            ]
          )
        ),
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
      body: CustomChat(
        messages: chatMessages.messages, 
        colorTheme: colorTheme, 
        size: size, 
        user: userPrincipal, 
        onSendMessage: ref.read(basicChatProvider.notifier).addMessage,
      ),
    );
  }
}