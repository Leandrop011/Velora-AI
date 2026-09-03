import 'package:flutter/material.dart';

class CustomTextTitle extends StatelessWidget {

  final String text;
  final Size size;
  final TextTheme textTheme;
  final bool fountValue;

  const CustomTextTitle({
    super.key, 
    required this.size,
    required this.textTheme,
    required this.fountValue, 
    required this.text,
  });


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.035),
        child: Text(
          text,
          style: textTheme.titleMedium?.copyWith(
            fontSize: size.width * 0.04,
            color: fountValue ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}

