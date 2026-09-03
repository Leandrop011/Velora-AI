
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemini_app/features/veloraAI/presentation/providers/providers.dart';

// ! WIDGET SCREEN DE CARGA

class CustomLoad extends ConsumerWidget {
  
  final Size size;
  final TextTheme textTheme;
  final ColorScheme colorTheme;
  final bool fountValue;
  final String image;

  const CustomLoad({
    super.key, 
    required this.size, 
    required this.textTheme, 
    required this.colorTheme, 
    required this.fountValue, 
    required this.image,
  });

  @override
  Widget build(BuildContext context, ref) {

    final valueLoader$ = ref.watch(valueLoaderProvider);

    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            // * image
            Container(
              width: size.width * 0.55,
              // height: size.height * 0.37,
              decoration: BoxDecoration(
                color: colorTheme.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: colorTheme.primary.withOpacity(0.8),
                    spreadRadius: 7,
                  )
                ]
              ),
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                        
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ) // ? animacion de movimiento en y
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .moveY(
                  begin: 0,
                  end: -20,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            
            SizedBox(height: size.height * 0.01,),
        
            // * text
            Text(
              'Velora', 
              style: textTheme.titleMedium?.copyWith(
                fontSize: size.width * 0.1
              ),
            ),
        
            SizedBox(height: size.height * 0.01,),
        
            Text(
              'Cargando tus mensajes....',
              style: textTheme.bodyMedium?.copyWith(
                fontSize: size.width * 0.04,
                color: fountValue ? Colors.grey : Colors.grey.shade800
              ),
            ),

            SizedBox(height: size.height * 0.1,),

            Container(
              width: size.width * 0.7,
              height: size.height * 0.01,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: colorTheme.primary.withOpacity(0.4)
                  )
                ]
              ),
              child: valueLoader$.when(
                data: (valueDots) => LinearProgressIndicator(
                  value: valueDots / 10,
                  borderRadius: BorderRadius.circular(10),
                ), 
                error: (error, stackTrace) => Text('Error: $error'), 
                loading: () => const SizedBox(),
              )
            ),
          
          ],
        ),
      ),
    );
  }
}