import 'package:flutter/material.dart';

class chatPage extends StatelessWidget {
  const chatPage({super.key});

  static const String nombre = 'chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat'))
    );
  }
}