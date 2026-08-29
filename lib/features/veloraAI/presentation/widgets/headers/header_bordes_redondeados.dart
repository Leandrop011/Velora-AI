
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HeaderBordesRedondeados extends StatelessWidget {

  final Size size;
  final String image;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final bool fountValueApp; 
  final double? valueBorderRadiusRigth;
  final double? valueBorderRadiusLeft;
  final double? valueBorder;
  final Color? colorBorder;

  const HeaderBordesRedondeados({
    super.key, 
    required this.size, 
    required this.image, 
    required this.colorTheme,
    required this.textTheme, 
    required this.fountValueApp, 
    this.valueBorderRadiusRigth, 
    this.valueBorderRadiusLeft, 
    this.valueBorder, 
    this.colorBorder, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        color: colorTheme.primaryContainer,
        border: Border(
          bottom: BorderSide(width: valueBorder ?? 0, color: colorBorder ?? Colors.transparent),
          right: BorderSide(width: valueBorder ?? 0, color: colorBorder ?? Colors.transparent),
          left: BorderSide(width: valueBorder ?? 0, color: colorBorder ?? Colors.transparent),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(valueBorderRadiusLeft ?? 0),
          bottomRight: Radius.circular(valueBorderRadiusRigth ?? 0),
        ),
        boxShadow: [
          BoxShadow(
            color: colorTheme.primary,
            spreadRadius: 1,
            blurRadius: 30,
            blurStyle: BlurStyle.normal,
            offset: const Offset(5, 2)
          )
        ]
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // * image avatar
            FadeInDown(
              curve: Curves.elasticInOut,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(100),
                child: Image.asset(
                  width: size.width * 0.3,
                  height: size.height * 0.2,
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            SizedBox(width: size.width * 0.05,),

            // * text of 'Velora'
            SizedBox(
              width: size.width * 0.5, // ? definir un size para previnir desbordamiento
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  // ? text
                  Text(
                    'Velora AI',
                    style: textTheme.labelMedium?.copyWith(
                      fontSize: size.width * 0.07,
                      shadows: [
                        BoxShadow(
                          blurRadius: 10,
                          blurStyle: BlurStyle.normal,
                          color: colorTheme.primary,
                          offset: const Offset(3, 2),
                        )
                      ]
                    ),
                  ),
              
                  SizedBox(height: size.height * 0.01,),
                  // ? subtext
                  Text(
                    'Tu chatbot AI de confianza. Conversa con Velora, resuelve dudas y obtén respuestas al instante, siempre a la mano.',
                    style: textTheme.bodyMedium?.copyWith(color: fountValueApp ? Colors.grey.shade400 : Colors.grey.shade700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
