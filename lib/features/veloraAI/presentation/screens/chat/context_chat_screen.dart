import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';

class ContextChatScreen extends ConsumerWidget {
  const ContextChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final fountValue = ref.watch(appFountValueProvider).value;
    final isReadyMessagesLoad$ = ref.watch(valueWhenMessagesReadyProvider);
    
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return isReadyMessagesLoad$.when(
      data: (_) => FadeIn( // * si el provider devuelve el booleano construye este widget
        duration: const Duration(seconds: 1),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Context Chat',
              style: textTheme.titleLarge?.copyWith(
                shadows: [
                  BoxShadow(
                    blurRadius: 10,
                    color: colorTheme.primary.withOpacity(0.8),
                    offset: const Offset(2, 2),
                  )
                ]
              ),
            ),
            centerTitle: true,
            
            actions: [
          
              Padding(
                padding: EdgeInsetsGeometry.only(right: size.width * 0.01),
                child: FilledButton(
                  onPressed: () => {
                    CustomShowDialog().infoMake(
                      context, 
                      'Esta seguro de eliminar este chat?', 
                      "Si pulsa la opcion 'si' se eliminara este chat con todo su historial conversacional y se creara uno nuevo.", 
                      [
                        FilledButton(
                          onPressed: (){
                            ref.read(chatWithContextProvider.notifier).newChat();
                            HapticFeedback.mediumImpact();
                            context.pop();
                            CustomSnackBar.snackBar(
                              context, 
                              'Eliminado con exito!', 
                              textTheme, 
                              colorTheme, 
                              fountValue
                            );
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          child: const Text('Si'),
                        ),
                        FilledButton(
                          onPressed: () => context.pop(), 
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          child: const Text('No'),
                        ),
                      ], 
                      textTheme
                    ),
                  }, 
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.delete)
                ),
              ),
            ],
          ),
        
          body: _BodyView(
            colorTheme: colorTheme, 
            size: size, 
            textTheme: textTheme,
          ),
        ),
      ), 
      error: (error, stackTrace) => Center(child: Text('Error: $error'),), 
      loading: () => CustomLoad(
        image: 'assets/avatar/velora-avatar-01.png',
        size: size, 
        textTheme: textTheme, 
        colorTheme: colorTheme, 
        fountValue: fountValue, 
      ),
    ); 
  }
}

// * BODY VIEW
class _BodyView extends ConsumerWidget {

  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final Size size;

  const _BodyView({
    required this.colorTheme, 
    required this.textTheme, 
    required this.size
  });

  @override
  Widget build(BuildContext context, ref) {

    final messageChatContext = ref.watch(chatWithContextProvider);
    final userPrincipal = ref.watch(userPrincipalProvider);

    return CustomChat( // ? widget de chat
      messages: messageChatContext.messagesFiles, 
      colorTheme: colorTheme, 
      size: size, 
      user: userPrincipal,
      inputToMessage: CustomBottomInput(
        onSend: (prompt, {images = const[]}) {
          HapticFeedback.mediumImpact();
          ref.read(chatWithContextProvider.notifier).addMessage(userPrincipal, prompt, images: images);
        },
      ),
    );
  }
}