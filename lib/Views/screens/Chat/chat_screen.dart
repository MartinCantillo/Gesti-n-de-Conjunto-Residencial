import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Views/Components/messageField_component.dart';

import 'package:gestionresidencial/Views/Widgets/chat/myMessage_widget.dart';
import 'package:gestionresidencial/Views/Widgets/chat/youMessage_widget.dart';
import 'package:gestionresidencial/Views/Widgets/home/NavBar/floatingNavBar.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  static const String nombre = 'chat';

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    return Scaffold(
      body: _NewChat(),
      bottomNavigationBar: FloatingNavBar(),
    );
  }
}

class _NewChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
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
      ),
    );
  }
}
