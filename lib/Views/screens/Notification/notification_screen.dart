import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  static const String nombre= "notificationPage";

  @override
  ConsumerState<NotificationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: const Center(
        child: Text("Aquí van las notificaciones"),
      ),
    );
  }
}
