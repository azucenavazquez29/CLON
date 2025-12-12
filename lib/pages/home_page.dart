// PANTALLA PRINCIPAL DEL HOME DE WAS

import 'package:flutter/material.dart';

// Importa tus otras páginas
import 'package:flutter_application_whatsaap/pages/chat_page.dart';
import 'package:flutter_application_whatsaap/pages/calls_page.dart';
import 'package:flutter_application_whatsaap/pages/chat_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> titles = ["Chats", "Estados", "Llamadas", "Perfil"];

  final List<Widget> pages = const [
    ChatsSection(),
    StatusSection(),
    CallsSection(),
    ProfileSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),

      appBar: AppBar(
        backgroundColor: const Color(0xff0B4F6C), // Azul TecNM
        title: Text(
          "TecNM Chat - ${titles[selectedIndex]}",
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff0B4F6C),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: "Estados",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: "Llamadas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}

// ======================
//       SECCIONES
// ======================

// CHATS
class ChatsSection extends StatelessWidget {
  const ChatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatPage(); // Usa tu ChatPage
  }
}

// STATUS
class StatusSection extends StatelessWidget {
  const StatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/user1.jpg"),
          ),
          title: Text("Mi estado"),
          subtitle: Text("Toca para actualizar tu estado"),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/user2.png"),
          ),
          title: Text("Karla Azucena"),
          subtitle: Text("Hoy, 9:30 AM"),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/group.png"),
          ),
          title: Text("Grupo 8A Sistemas"),
          subtitle: Text("Ayer, 8:00 PM"),
        ),
      ],
    );
  }
}

// CALLS
class CallsSection extends StatelessWidget {
  const CallsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const CallsPage(); // Usa tu CallsPage
  }
}

// PROFILE
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/user1.png"),
          ),
          SizedBox(height: 15),
          Text(
            "Usuario TecNM",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text("Ingeniería en Sistemas Computacionales"),
          SizedBox(height: 20),
          Text("Estado: Disponible", style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
