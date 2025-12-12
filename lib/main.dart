// Pantalla principal

import 'package:flutter/material.dart';
import 'package:flutter_application_whatsaap/pages/home_page.dart';
import 'package:flutter_application_whatsaap/pages/chat_page.dart';
import 'package:flutter_application_whatsaap/pages/chat_detail.dart';
import 'package:flutter_application_whatsaap/pages/status_page.dart';
import 'package:flutter_application_whatsaap/pages/calls_page.dart';
import 'package:flutter_application_whatsaap/pages/profile_page.dart';

void main() {
  runApp(const TecNMChat());
}

class TecNMChat extends StatelessWidget {
  const TecNMChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/home',

      routes: {
        '/home': (context) => const HomePage(),

        // Secciones principales del Home
        '/chats': (context) => const ChatPage(),
        '/status': (context) => const StatusPage(),
        '/calls': (context) => const CallsPage(),
        '/profile': (context) => const ProfilePage(),

        // Chat individual
        '/chatDetail': (context) => const ChatDetailPage(),
      },
    );
  }
}
