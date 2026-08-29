import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:gemini_app/config/theme/app_theme.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';

class ConfigAppThemeScreen extends StatelessWidget {
  const ConfigAppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas'),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () => CustomShowDialog().infoMake(
              context, 
              'Informacion', 
              'En esta seccion puedes cambiar el tema de la aplicacion, selecciona el color que mas te guste.', 
              [
                FilledButton(
                  onPressed: () => context.pop(), 
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    )
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
        textTheme: textTheme,
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

    final valueThemeApp = ref.watch(appThemeValueProvider).value;

    return ListView.builder(
      itemCount: listColors.length,
      itemBuilder: (context, index) {

        final color = listColors[index];

        return ZoomInDown(
          child: ListTileWidget(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.008),
            title: 'Color: ${color.$1}',
            subTitle: 'Color ${index + 1}', 
            border: Border.all(width: 2, color: color.$2),
            backGroundColorBox: Colors.black87,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                blurStyle: BlurStyle.normal,
                spreadRadius: 1,
                offset: const Offset(2, 2),
                color: color.$2,
              )
            ],
            actions: Radio(
              // ? al group que pertenece (list of colors)
              groupValue: index, 
              // ? color que tendra cuando este activo
              activeColor: color.$2,
              // ? valor seleccionado actualmente
              value: valueThemeApp,
              // ? color when is inactive
              hoverColor: Colors.white,
              // ? callback que se ejecuta para cambiar el value (value es el elemento que se selecciona) 
              onChanged: (value) => ref.read(appThemeValueProvider.notifier).changeThemeValue(value ?? 0),
            ),
            // ? se manda el index del elemento que se seleciono
            onPressed: (){
              HapticFeedback.mediumImpact();
              ref.read(appThemeValueProvider.notifier).changeThemeValue(index);
            }, 
            colorTheme: colorTheme, 
            textTheme: textTheme, 
            size: size
          ),
        );
      },
    );
  }
}
