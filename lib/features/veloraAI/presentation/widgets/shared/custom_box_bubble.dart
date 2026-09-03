import 'package:flutter/material.dart';

class CustomBoxBubble extends StatelessWidget {

  final Size size;
  final ColorScheme colorTheme;
  final BorderRadiusGeometry? borderRadius;

  const CustomBoxBubble({
    super.key, 
    required this.size, 
    required this.colorTheme, 
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.elasticInOut,
      width: size.width * 0.2,
      height: size.height * 0.13,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
            color: colorTheme.primary.withOpacity(0.7),
            spreadRadius: 10,
          )
        ],
        color: Colors.transparent,
        borderRadius: borderRadius
      ),
    );
  }
}