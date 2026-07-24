
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomShowDialog {
  
  void infoMake( 
    BuildContext context, 
    String title, 
    String content, 
    List<Widget> actions, 
    TextTheme textTheme 
  ){
    showDialog(
      context: context, 
      barrierColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }

}
