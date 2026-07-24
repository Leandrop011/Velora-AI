import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gemini_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Velora AI', style: textTheme.titleLarge,),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () => context.push('config-app'), 
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: ListView(
        children: [
          
          // * Header inicial
          FadeInDown(
            duration: const Duration(seconds: 1),
            child: HeaderBordesRedondeados(
              size: size, 
              image: 'assets/avatar/velora-avatar-01.png',
              valueBorderRadiusLeft: 50,
              valueBorderRadiusRigth: 50,
              colorTheme: colorTheme,
              valueBorder: 2,
              colorBorder: colorTheme.primary.withOpacity(0.6),
            ),
          ),

          // * --- Elementos ---
          ZoomIn(
            duration: const Duration(seconds: 1),
            child: ListileWidget(
              title: 'Conversacion Basica con Velora', 
              onPressed: () => context.push('/basic-prompt'),
              subTitle: 'Inicia una conversacion con Velora',
              leading: CircleAvatar(
                backgroundColor:  colorTheme.primary.withOpacity(0.6),
                child: const Icon(Icons.person_outline),
              ),
              size: size,
              iconTrailing: Icons.arrow_forward_ios_rounded,
              colorTheme: colorTheme,
              textTheme: textTheme,
            ),
          ),

        ],
      )
    );
  }
}