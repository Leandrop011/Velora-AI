
import 'package:flutter/material.dart';

class ListileWidget extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final Size size;
  final String? subTitle;
  final IconData? iconTrailing;
  final Widget? leading;

  const ListileWidget({
    super.key, 
    required this.title, 
    required this.onPressed, 
    required this.colorTheme, 
    required this.textTheme, 
    required this.size, 
    this.subTitle, 
    this.iconTrailing, 
    this.leading, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02, 
        vertical: size.height * 0.035
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: colorTheme.primary),
          borderRadius: BorderRadius.circular(20)
        ),
        child: ListTile(
          leading: leading,
          title: Text(title, style: textTheme.titleMedium,),
          subtitle: Text(subTitle ?? '', style: textTheme.bodySmall,),
          onTap: () => onPressed(),
          trailing: Icon(iconTrailing, color: colorTheme.primary,),
        ),
      ),
    );
  }
}
