import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static const String nombre = 'chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: false,
      ),
      body: _NewChat(),
    );
  }
}

class _NewChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text('Indice : $index');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}