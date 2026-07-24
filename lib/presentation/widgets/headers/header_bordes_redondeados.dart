
import 'package:flutter/material.dart';

class HeaderBordesRedondeados extends StatelessWidget {

  final Size size;
  final String image;
  final ColorScheme colorTheme;
  final double? valueBorderRadiusRigth;
  final double? valueBorderRadiusLeft;
  final double? valueBorder;
  final Color? colorBorder;

  const HeaderBordesRedondeados({
    super.key, 
    required this.size, 
    required this.image, 
    required this.colorTheme,
    this.valueBorderRadiusRigth, 
    this.valueBorderRadiusLeft, 
    this.valueBorder, 
    this.colorBorder, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.3,
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
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Image.asset(
            width: size.width * 0.3,
            height: size.height * 0.2,
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
