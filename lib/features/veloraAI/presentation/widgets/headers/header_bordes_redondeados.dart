
import 'package:flutter/material.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/widgets.dart';

// ! UN HEADER CON BORDES REDONDEADOS
class HeaderBordesRedondeados extends StatelessWidget {

  final Size size;
  final String image;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final bool fountValueApp; 
  final String title;
  final BoxFit? fit;
  final String? subtitle;
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
    required this.title, 
    this.valueBorderRadiusRigth, 
    this.valueBorderRadiusLeft, 
    this.valueBorder, 
    this.colorBorder, 
    this.subtitle, 
    this.fit, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.elasticInOut,
        width: size.width,
        // height: size.height * 0.4,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: valueBorder ?? 2, color: colorBorder ?? colorTheme.primary),
            left: BorderSide(width: valueBorder ?? 2, color: colorBorder ?? colorTheme.primary),
            right: BorderSide(width: valueBorder ?? 2, color: colorBorder ?? colorTheme.primary),
          ),
          color: fountValueApp ? Colors.black87 : Colors.white70,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(valueBorderRadiusLeft ?? 5),
            bottomRight: Radius.circular(valueBorderRadiusRigth ?? 5),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              blurStyle: BlurStyle.normal,
              color: colorTheme.primary,
              offset: const Offset(2, 2)
            )
          ]
        ),
      
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            
            Positioned(
              top: 0,
              right: 0,
              child: CustomBoxBubble(
                size: size, 
                colorTheme: colorTheme,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100)
                ),
              ),
            ),
    
            Positioned(
              bottom: 13,
              left: 10,
              child: CustomBoxBubble(
                size: size, 
                colorTheme: colorTheme,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(valueBorderRadiusLeft ?? 0),
                  topRight: const Radius.circular(100)
                )
              ),
            ),
        
            SizedBox(height: size.height * 0.01,),
            
            // * content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: size.height * 0.03,),

                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    width: size.width * 0.65,
                    height: size.height * 0.2,
                    image,
                    fit: fit,
                  ),
                ),
    
                SizedBox(height: size.height * 0.01,),
                
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: size.width * 0.05,
                  ),
                ),
    
                SizedBox(height: size.height * 0.01,),
                
                Text(
                  subtitle ?? '',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: size.width * 0.03,
                    color: fountValueApp ? Colors.grey.shade500 : Colors.grey.shade700
                  ),
                ),
    
                SizedBox(height: size.height * 0.01,),
    
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                  ),
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Center(
                        child: Text(
                          'Version 1.0.0',
                          style: textTheme.titleMedium?.copyWith(color: Colors.white),
                        )
                      ),
                      
                      SizedBox(width: size.width * 0.01,),
                    
                      Icon(Icons.verified_sharp, color: colorTheme.primary,),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03,)
              ],
            ),
          ],
        )
      ),
    );
  }
}
