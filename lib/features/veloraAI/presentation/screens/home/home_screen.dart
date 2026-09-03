import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/features/veloraAI/domain/domain.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  bool changePhotoAvatar = true;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fountAppValue = ref.watch(appFountValueProvider).value;

    // ! LIST DE CADA ITEM DEL HOME SCREEN (SCREENS CHATS)
    List<ItemChat> listItemsScreensChats = [
      ItemChat(
        title: 'Conversacion Basica con Velora', 
        subTitle: 'Inicia una conversacion con Velora basica solo texto, y sin memoria.', 
        route: '/basic-prompt', 
        leading: CircleAvatar(
          backgroundColor:  colorTheme.primary.withOpacity(0.6),
          child: const Icon(Icons.person_outline),
        ), 
        actions: Icon(Icons.arrow_forward_ios_rounded, color: colorTheme.primary,),
      ),
      ItemChat(
        title: 'Mensajes y archivos con Velora', 
        subTitle: 'Inicia una conversacion con Velora y la posibilidad de subir archivos', 
        route: '/prompt-files', 
        leading: CircleAvatar(
          backgroundColor: colorTheme.primary.withOpacity(0.6),
          child: const Icon(Icons.file_present_rounded),
        ), 
        actions: Icon(Icons.arrow_forward_ios_rounded, color: colorTheme.primary,),
      ),
      ItemChat(
        title: 'Maneja el contexto y el historial con Velora', 
        subTitle: 'Manten el contexto en una conversacion y su historial', 
        route: '/context-chat', 
        leading: CircleAvatar(
          backgroundColor: colorTheme.primary.withOpacity(0.6),
          child: const Icon(Icons.forum_rounded),
        ), 
        actions: Icon(Icons.arrow_forward_ios_rounded, color: colorTheme.primary,),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Velora AI', 
          style: textTheme.titleLarge?.copyWith(
            color: colorTheme.primary,
            shadows: [
              Shadow(
                blurRadius: 9,
                color: colorTheme.primary.withOpacity(0.8),
                offset: const Offset(2, 2)
              )
            ]
          ),
        ),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: (){
                context.push('config-app');
                HapticFeedback.mediumImpact();
              }, 
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                ),
              ),
              child: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
        
            // * Header inicial
            FadeInDown(
              duration: const Duration(seconds: 1),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  setState(() {
                    changePhotoAvatar = !changePhotoAvatar;
                  });
                },
                child: HeaderBordesRedondeados(
                  size: size,
                  title: 'Velora',
                  image: (changePhotoAvatar) ? 
                        'assets/avatar/velora-avatar-01.png' 
                        : 
                        'assets/avatar/velora-avatar-02.png',
                  fit: BoxFit.contain,
                  valueBorderRadiusLeft: changePhotoAvatar ? 50 :100,
                  valueBorderRadiusRigth: changePhotoAvatar ? 50 : 100,
                  colorTheme: colorTheme,
                  valueBorder: 2,
                  textTheme: textTheme,
                  fountValueApp: fountAppValue,
                  colorBorder: colorTheme.primary.withOpacity(0.6),
                ),
              ),
            ),
        
            // * --- Elementos ---  
            // ? sin expand para no conflictos con el singlechildscroll
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.023),
              child: ListView.builder(
                shrinkWrap: true, // ? evitar conflictos de espacio por estar dentro de un column
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listItemsScreensChats.length,
                itemBuilder: (context, index) {
                  final item = listItemsScreensChats[index];
              
                  return ZoomIn(
                    duration: const Duration(seconds: 1),
                    child: ListTileWidget(
                      title: item.title, 
                      subTitle: item.subTitle,
                      onPressed: () => context.push(item.route),
                      leading: item.leading,
                      actions: item.actions,
                      size: size,
                      textTheme: textTheme,
                      colorTheme: colorTheme,
                      padding: EdgeInsets.symmetric( 
                        horizontal: size.width * 0.01,
                        vertical: size.height * 0.005 
                      ),
                      colorText: fountAppValue ? Colors.white : Colors.black,
                      backGroundColorBox: colorTheme.primary.withOpacity(0.15),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      )
    );
  }
}

