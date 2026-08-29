import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';

class PromptFilesChatScreen extends StatelessWidget {
  const PromptFilesChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Velora Files',
          style: textTheme.titleLarge?.copyWith(
            shadows: [
              Shadow(
                blurRadius: 10,
                color: colorTheme.primary.withOpacity(0.8),
                offset: const Offset(2, 2)
              )
            ]
          ),
        ),
        
        centerTitle: true,


        actions: [
          IconButton(
            onPressed: () => CustomShowDialog().infoMake(
              context, 
              'Informacion', 
              'Esta pantalla es un chat de Velora AI, donde puedes enviarle mensajes y archivos para que pueda procesarlos y responderte. Puedes enviar mensajes de texto y adjuntar archivos para obtener respuestas más precisas.', 
              [
                FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ), 
                  child: const Text('Ok'),
                )
              ], 
              textTheme
            ), 
            icon: const Icon(Icons.info_rounded)
          )
        ],
      
      ),

      body: _BodyView(
        colorTheme: colorTheme,
        size: size,
      ),
    );
  }
}

// ! BODY VIEW
class _BodyView extends ConsumerWidget {

  final ColorScheme colorTheme;
  final Size size;

  const _BodyView({
    required this.colorTheme, 
    required this.size
  });

  @override
  Widget build(BuildContext context, ref) {

    final chatProvider = ref.watch(promptFileChatProvider);
    final userPincipal = ref.watch(userPrincipalProvider);

    return CustomChat(
      messages: chatProvider.messagesFiles, 
      colorTheme: colorTheme, 
      size: size, 
      user: userPincipal,
      inputToMessage: CustomBottomInput(
        // ? funcion onsend, cuando se envia captura el texto del input y las images que posiblemente
        // ? se agrego
        // ! solo se ejecuta en su inicializacion y cuando el user enviar un message
        onSend: (message, {images = const[]}) {
          // ? y ejecutamos el provider que lo mandara la info al repository
          ref.read(promptFileChatProvider.notifier).addMessage(userPincipal, message, images: images);
          HapticFeedback.mediumImpact();
        },
      ),
    ); 
  }
}
