import 'package:flutter/material.dart';

class AvatarBoxWidget extends StatelessWidget {

  final Size size;
  final String image;
  final double? valueBorderRadius;
  final double? valueWidth;
  final double? valueHeight;

  const AvatarBoxWidget({
    super.key, 
    required this.size, 
    required this.image, 
    this.valueBorderRadius, 
    this.valueWidth, 
    this.valueHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: valueWidth ?? size.width * 0.08,
      height: valueHeight ?? size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(valueBorderRadius ?? 100),
      ),
      child: Image.asset(image),
    );
  }
}