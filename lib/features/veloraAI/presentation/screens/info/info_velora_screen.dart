
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/features/veloraAI/domain/domain.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/headers/headers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/shared/shared.dart';

class InfoVeloraScreen extends ConsumerWidget {
  const InfoVeloraScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final fountValue = ref.watch(appFountValueProvider).value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 30),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        title: Text(
          'Informacion de Velora', 
          style: textTheme.titleLarge?.copyWith(
            shadows: [
              BoxShadow(
                blurRadius: 10,
                blurStyle: BlurStyle.normal,
                color: colorTheme.primary,
                offset: const Offset(3, 2)
              )
            ]
          ),
        ),
        centerTitle: true,
      ),

      body: _BodyView( 
        colorTheme: colorTheme, 
        textTheme: textTheme, 
        size: size,
        fountValue: fountValue,
      ),

      extendBody: true,

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: SizedBox(
          height: size.height * 0.07,
          child: FilledButton.icon(
            onPressed: (){
              context.go('/');
              HapticFeedback.mediumImpact();
            }, 
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              )
            ),
            label: Text(
              'Empezar a chatear con Velora',
              style: textTheme.titleMedium?.copyWith(
                color: fountValue ? Colors.black : Colors.white
              ),
            ),
            icon: const Icon(Icons.chat_bubble),
          ),
        ),
      ),
    );
  }
}

// * BODY VIEW
class _BodyView extends ConsumerWidget {
  
  final TextTheme textTheme;
  final ColorScheme colorTheme;
  final Size size;
  final bool fountValue;

  const _BodyView({
    required this.textTheme, 
    required this.colorTheme, 
    required this.size, 
    required this.fountValue,
  });

  @override
  Widget build(BuildContext context, ref) {

    // * skills
    final List<ItemSkill> skills = [
      ItemSkill(
        skill: 'Conversaciones naturales', 
        descriptionSkill: 'Habla con Velora, como con una persona', 
        iconSkill: Icons.chat_bubble,
      ),
      ItemSkill(
        skill: 'Memoria de contexto', 
        descriptionSkill: 'Retoma cada charla donde la dejaste', 
        iconSkill: Icons.history_edu_rounded,
      ),
      ItemSkill(
        skill: 'Archivos de todo tipo', 
        descriptionSkill: 'Enviale un archivo de cualquier tipo para que lo analize por ti', 
        iconSkill: Icons.file_copy_rounded,
      ),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // * image avatar - header
          HeaderBordesRedondeados(
            size: size, 
            image: 'assets/avatar/velora-avatar-03.png', 
            fit: BoxFit.cover,
            colorTheme: colorTheme, 
            textTheme: textTheme, 
            fountValueApp: fountValue, 
            valueBorderRadiusLeft: 50,
            valueBorderRadiusRigth: 50,
            title: 'Velora',
            subtitle: 'Tu asistente conversacional con IA',
          ),

          SizedBox(height: size.height * 0.01,),

          // * about velora
          CustomBoxAbout(
            title: 'Acerca de Velora AI',
            description: 'Velora es un asistente de conversación impulsado por IA. Vel, tu compañera dentro de la app, entiende el contexto de tus charlas, recuerda lo importante y responde en segundos.',
            size: size, 
            fountValue: fountValue, 
            colorTheme: colorTheme, 
            textTheme: textTheme
          ), 

          SizedBox(height: size.height * 0.025,),

          // * title before to skills
          CustomTextTitle(
            text: 'QUE PUEDE HACER',
            size: size, 
            textTheme: textTheme, 
            fountValue: fountValue
          ),

          SizedBox(height: size.height * 0.005,),
          
          // * view skills (damos un heigth con el sizedbox, que tome el necesario los hijos)
          SizedBox(
            child: Column(
              children: skills.map(
                (skill) => CustomBoxCard(
                  title: skill.skill, 
                  description: skill.descriptionSkill,
                  icon: skill.iconSkill,
                  size: size, 
                  fountValue: fountValue, 
                  colorTheme: colorTheme, 
                  textTheme: textTheme, 
                ),
              ).toList(),
            ),
          ),

          SizedBox(height: size.height * 0.1,),

        ],
      ),
    );
  }
}