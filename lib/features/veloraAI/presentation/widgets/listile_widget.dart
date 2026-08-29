
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final Size size;
  final EdgeInsetsGeometry? padding; 
  final String? subTitle;
  final Widget? actions;
  final Widget? leading;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Color? backGroundColorBox;
  final Color? colorText;

  const ListTileWidget({
    super.key, 
    required this.title, 
    required this.onPressed, 
    required this.colorTheme, 
    required this.textTheme, 
    required this.size, 
    this.subTitle, 
    this.actions, 
    this.leading, 
    this.padding, 
    this.border, 
    this.boxShadow, 
    this.backGroundColorBox, 
    this.colorText, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(
        horizontal: size.width * 0.02, 
        vertical: size.height * 0.035
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColorBox ?? Colors.transparent ,
          border: border ?? Border.all(width: 2, color: colorTheme.primary),
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow ?? [],
        ),
        child: ListTile(
          leading: leading,
          title: Text(title, style: textTheme.titleMedium?.copyWith(color: colorText ?? Colors.white),),
          subtitle: Text(subTitle ?? '', style: textTheme.bodySmall?.copyWith(color: colorText ?? Colors.white),),
          onTap: () => onPressed(),
          trailing: actions,
        ),
      ),
    );
  }
}
