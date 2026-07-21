import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Gemini'),
      ),
      body: ListView(
        children: [
          // * --- Elementos ---
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person_outline),
            ),
            title: Text('Prompt Basico a Gemini'),
            subtitle: Text('Usando un modelo Flash'),
            onTap: () => context.push('/basic-prompt'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          
        ],
      )
    );
  }
}