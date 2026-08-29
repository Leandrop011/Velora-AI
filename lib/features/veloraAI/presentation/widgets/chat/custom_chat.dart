import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide Message;
import 'package:go_router/go_router.dart';

import '../widgets.dart';

class CustomChat extends StatelessWidget {

  final List<Message> messages;
  final ColorScheme colorTheme;
  final Size size;
  final User user;
  final void Function( // ? funtion opcional solo para el metodo onSendPressed (propio del package)
    User user, 
    PartialText message,
  )? onSendMessage;
  final Widget? inputToMessage;

  const CustomChat({
    super.key, 
    required this.messages, 
    required this.colorTheme, 
    required this.size, 
    required this.user, 
    this.onSendMessage, 
    this.inputToMessage
  });

  @override
  Widget build(BuildContext context) {
    return Chat(

      // * LSIT OF MESSAGES
      messages: messages, 

      // * METODO ONSENDMESSAGE
      onSendPressed: (message) {
        onSendMessage?.call(user, message);
        HapticFeedback.mediumImpact();
      }, 

      // * BOTTOM PERSONALIZADO
      customBottomWidget: inputToMessage, 

      // * TEMA 
      theme: DarkChatTheme( 
        backgroundColor: colorTheme.primary.withOpacity(0.2),
        primaryColor: colorTheme.primary.withOpacity(0.3),
        inputTextColor: Colors.white,
        userAvatarNameColors: [colorTheme.primary.withOpacity(0.8)],
        inputBackgroundColor: colorTheme.primary.withOpacity(0.2),
        secondaryColor: colorTheme.primary.withOpacity(0.2),
      ),

      // * OPTIONS TO THE INPUT MESSAGE
      inputOptions: const InputOptions(
        autocorrect: true,
      ),

      // * AVATAR
      avatarBuilder: (_) {
        return GestureDetector(
          onTap: () => context.push('info-velora'),
          child: AvatarBoxWidget(
            size: size, 
            image: 'assets/avatar/velora-avatar-01.png'
          ),
        );
      },

      showUserNames: true,
      showUserAvatars: true,

      // * USER PRINCIPAL
      user: user
    );
  }
}
