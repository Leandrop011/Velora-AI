
import 'package:flutter/widgets.dart';

class ItemChat {
  final String title;
  final String subTitle;
  final String route;
  final Widget leading;
  final Widget actions;

  ItemChat({
    required this.title, 
    required this.subTitle, 
    required this.leading, 
    required this.actions,
    required this.route, 
  });
}
