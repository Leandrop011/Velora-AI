
import 'package:flutter/material.dart';

class ConfigAppScreen extends StatelessWidget {
  const ConfigAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion App', style: textTheme.titleLarge,),
        centerTitle: true,
      ),
    );
  }
}
