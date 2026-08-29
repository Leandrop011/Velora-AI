
import 'package:flutter/material.dart';

class InfoVeloraScreen extends StatelessWidget {
  const InfoVeloraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion de Velora', style: textTheme.titleLarge,),
        centerTitle: true,
      ),
    );
  }
}
