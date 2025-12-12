// en el chat

import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xff075E54),
        title: const Text("WhatsApp"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar búsqueda de chats
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Opciones del menú
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "nuevo_grupo",
                child: Text("Nuevo grupo"),
              ),
              const PopupMenuItem(value: "ajustes", child: Text("Ajustes")),
            ],
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 5),
        children: [
          chatTile(
            context: context,
            name: "Profesor Ruben",
            message: "Recordatorio: tarea para mañana",
            time: "10:12 AM",
            avatar: "assets/user1.png",
            unreadCount: 2,
          ),
          const Divider(height: 0),
          chatTile(
            context: context,
            name: "Grupo 8A Sistemas",
            message: "Aviso importante del docente",
            time: "9:40 AM",
            avatar: "assets/group.png",
            unreadCount: 0,
          ),
          const Divider(height: 0),
          chatTile(
            context: context,
            name: "Karla Azucena",
            message: "¿Ya viste el proyecto?",
            time: "Ayer",
            avatar: "assets/user2.png",
            unreadCount: 1,
          ),
          const Divider(height: 0),
          chatTile(
            context: context,
            name: "Laboratorio Redes",
            message: "Equipo actualizado",
            time: "Ayer",
            avatar: "assets/fondo.jpg",
            unreadCount: 0,
          ),
        ],
      ),
    );
  }

  // ==============================
  //   ITEM DE CADA CHAT
  // ==============================

  Widget chatTile({
    required BuildContext context,
    required String name,
    required String message,
    required String time,
    required String avatar,
    int unreadCount = 0,
  }) {
    return ListTile(
      leading: CircleAvatar(radius: 26, backgroundImage: AssetImage(avatar)),

      title: Text(
        name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey.shade600),
      ),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xff25D366),
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),

      // 🔥 Navegación hacia el chat individual
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chatDetail',
          arguments: {"name": name, "avatar": avatar},
        );
      },
    );
  }
}
