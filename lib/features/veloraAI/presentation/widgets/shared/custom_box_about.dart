import 'package:flutter/material.dart';

class CustomBoxAbout extends StatelessWidget {

  final String title;
  final String description;
  final Size size;
  final bool fountValue;
  final ColorScheme colorTheme;
  final TextTheme textTheme;

  const CustomBoxAbout({
    super.key, 
    required this.size,
    required this.fountValue,
    required this.colorTheme,
    required this.textTheme, 
    required this.title, 
    required this.description,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
        right: size.width * 0.02,
        left: size.width * 0.02,
        bottom: size.height * 0.01
      ),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: colorTheme.primaryContainer.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: fountValue ? Colors.white12 : Colors.black12),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              // spreadRadius: -3,s
              blurStyle: BlurStyle.normal,
              color: fountValue ? Colors.white12 : Colors.black26,
              offset: const Offset(-1, 7)
            ),
          ],
        ),
        child: Column(
          children: [
            
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.015, left: size.width * 0.015),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: colorTheme.primary,),
                  SizedBox(width: size.width * 0.01,),
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
    
            SizedBox(height: size.height * 0.01,),
    
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.035,
                right: size.width * 0.02,
                bottom: size.height * 0.03
              ),
              child: Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: fountValue ? Colors.white60 : Colors.black54
                ),
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}
