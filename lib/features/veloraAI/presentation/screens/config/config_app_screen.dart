
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:gemini_app/config/theme/app_theme.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';

class ConfigAppScreen extends StatelessWidget {
  const ConfigAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones', style: textTheme.titleLarge,),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _BodyView(
          colorTheme: colorTheme, 
          textTheme: textTheme, 
          size: size,
        ),
      ),

    );
  }
}

// ! BODY VIEW
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

    final fountAppValue = ref.watch(appFountValueProvider).value;
    final themeAppValue = ref.watch(appThemeValueProvider).value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // * TITLE BEFORE TO ITEMS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: size.height * 0.005),
          child: Text(
            'Personalizar',
            style: textTheme.titleLarge,
          ),
        ),

        // * ITEMS OF CONFIG APP
        _ItemsView(
          size: size, 
          fountAppValue: fountAppValue, 
          colorTheme: colorTheme, 
          textTheme: textTheme, 
          themeAppValue: themeAppValue
        ),

        // * FOOTER
        CustomFooter(
          size: size, 
          textTheme: textTheme, 
          colorTheme: colorTheme, 
          padding: EdgeInsets.only( top: size.height * 0.4 ),
          labelPhrase: 'Velora AI - tu compañia con AI, siempre a tu lado', 
          labelVersion: 'Version 1.0.0'
        ),
      ],
    );
  }
}

// ! LIST OF ITEMS
class _ItemsView extends ConsumerWidget {
  const _ItemsView({
    required this.size,
    required this.fountAppValue,
    required this.colorTheme,
    required this.textTheme,
    required this.themeAppValue,
  });

  final Size size;
  final bool fountAppValue;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final int themeAppValue;

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: colorTheme.secondary.withOpacity(0.2)
          ),
        ),
        child: Column(
          children: [
            // * TILE DE CAMBIO DE FOUNT APP
            ListTileWidget(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
              title: 'Cambiar Fondo de la App a: ${fountAppValue ? 'Claro' : 'Oscuro'}',
              subTitle: 'Se cambiara el fondo de la app entre modo oscuro y modo claro',
              colorText: fountAppValue ? Colors.white : Colors.black,
              backGroundColorBox: Colors.transparent,
              border: Border.all(color: Colors.transparent),
              actions: Switch(
                value: fountAppValue, 
                onChanged: (value) => ref.read(appFountValueProvider.notifier).changeFountValue(value),
              ), 
              leading: Icon( fountAppValue ? Icons.lightbulb_rounded : Icons.dark_mode_rounded, color: colorTheme.primary,),
              onPressed: () {
                // ? valor contrario !, porque este onpressed no tenemos el value que nos da el toggle
                ref.read(appFountValueProvider.notifier).changeFountValue(!fountAppValue);
                HapticFeedback.mediumImpact();
              }, 
              colorTheme: colorTheme, 
              textTheme: textTheme, 
              size: size,
            ),

            Divider(
              color: fountAppValue ? Colors.white24 : Colors.grey,
              height: size.height * 0.005,
              thickness: 1,
            ),
        
            // * TILE DE CAMBIO DE THEME APP
            ListTileWidget(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
              title: 'Cambiar Tema de la App',
              subTitle: 'Se cambiara el tema de la app, actual seleccionado: ${listColors[themeAppValue].$1}',
              colorText: fountAppValue ? Colors.white : Colors.black,
              backGroundColorBox: Colors.transparent,
              border: Border.all(color: Colors.transparent),
              actions: Icon(Icons.arrow_forward_ios_rounded, color: colorTheme.primary,), 
              leading: Icon(Icons.palette_rounded, color: colorTheme.primary,),
              onPressed: () => context.push('config-app-theme'), 
              colorTheme: colorTheme, 
              textTheme: textTheme, 
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}
