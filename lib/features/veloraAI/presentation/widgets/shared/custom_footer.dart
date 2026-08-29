
import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {

  final Size size;
  final TextTheme textTheme;
  final ColorScheme colorTheme;
  final String labelPhrase;
  final String labelVersion;
  final EdgeInsetsGeometry? padding;

  const CustomFooter({
    super.key, 
    required this.size, 
    required this.textTheme, 
    required this.colorTheme, 
    required this.labelPhrase, 
    required this.labelVersion, 
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: size.height * 0.55),
      child: Center(
        child: Column(
          children: [
            
            Text(
              labelPhrase, 
              style: textTheme.bodyMedium?.copyWith( 
                color: colorTheme.primary.withOpacity(0.6),
                fontWeight: FontWeight.bold 
              ),
            ),
              
            SizedBox( height: size.height * 0.01, ),
            
            Text(
              labelVersion,
              style: textTheme.bodyMedium?.copyWith( 
                color: colorTheme.primary.withOpacity(0.7),
                fontWeight: FontWeight.bold 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
