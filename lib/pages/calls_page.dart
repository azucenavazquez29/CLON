// Archivo para las videollamadas

import 'package:flutter/material.dart';

// Página de llamadas recientes
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),

          // ENCABEZADO
          const Text(
            "Llamadas recientes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B4F6C),
            ),
          ),

          const SizedBox(height: 20),

          // EJEMPLOS DE LLAMADAS
          callTile(
            name: "Profesor Ruben",
            time: "Hoy, 10:32 AM",
            incoming: true,
            avatar: "assets/user1.jpg",
          ),

          callTile(
            name: "Alumno Oscar",
            time: "Ayer, 7:12 PM",
            incoming: false,
            avatar: "assets/user2.png", // corregido el typo
          ),

          callTile(
            name: "Grupo 8A Sistemas PROGRAMACION MOVIL",
            time: "Ayer, 3:55 PM",
            incoming: true,
            avatar: "assets/group.png",
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF157F1F),
        shape: const CircleBorder(),
        child: const Icon(Icons.videocam, color: Colors.white),
        onPressed: () {
          // Navegar a la pantalla de videollamada
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VideoCallPage()),
          );
        },
      ),
    );
  }

  Widget callTile({
    required String name,
    required String time,
    required bool incoming,
    required String avatar,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: AssetImage(avatar),
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Icon(
            incoming ? Icons.call_received : Icons.call_made,
            size: 18,
            color: incoming ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 6),
          Text(time),
        ],
      ),
      trailing: const Icon(Icons.call, color: Color(0xFF0B4F6C), size: 28),
    );
  }
}

// Nueva pantalla de videollamada
class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Videollamada"),
        backgroundColor: const Color(0xFF0B4F6C),
      ),
      body: const Center(
        child: Text(
          "Aquí se mostrará la videollamada (WebRTC/Agora)",
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
