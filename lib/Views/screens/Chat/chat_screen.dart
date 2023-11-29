import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Components/messageField_component.dart';
import 'package:gestionresidencial/Views/Widgets/chat/myMessage_widget.dart';
import 'package:gestionresidencial/Views/Widgets/chat/youMessage_widget.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static const String nombre = 'chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return (index % 2 == 0)
                      ? const MyMessageBubble()
                      : const YouMessageBubble();
                },
              ),
            ),
          ),
          const MessageFieldBox(),
        ],
      ),
    );
  }
}
