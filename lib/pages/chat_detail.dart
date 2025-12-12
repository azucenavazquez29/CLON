// detalles del chat

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [
    {"fromMe": false, "text": "Hola, ¿cómo estás?", "time": "10:12 AM"},
    {"fromMe": true, "text": "Todo bien, gracias. ¿Y tú?", "time": "10:13 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String name = args["name"];
    final String avatar = args["avatar"];

    return Scaffold(
      backgroundColor: const Color(0xffECE5DD), // color WhatsApp chat
      appBar: AppBar(
        backgroundColor: const Color(0xff075E54),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(avatar)),
            const SizedBox(width: 10),
            Text(name),
          ],
        ),
      ),

      body: Column(
        children: [
          // =======================
          //        MENSAJES
          // =======================
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final bool fromMe = msg["fromMe"];

                return Align(
                  alignment: fromMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: fromMe
                          ? const Color(0xffDCF8C6) // verde whatsapp
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(14),
                        topRight: const Radius.circular(14),
                        bottomLeft: fromMe
                            ? const Radius.circular(14)
                            : Radius.zero,
                        bottomRight: fromMe
                            ? Radius.zero
                            : const Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(msg["text"], style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 3),
                        Text(
                          msg["time"],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // =======================
          //    CAJA DE MENSAJE
          // =======================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  color: Colors.grey.shade600,
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "Mensaje",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: sendMessage,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff25D366),
                    child: Icon(
                      _controller.text.isEmpty ? Icons.mic : Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "fromMe": true,
        "text": _controller.text.trim(),
        "time": _getCurrentTime(),
      });
    });

    _controller.clear();
    _scrollToBottom();

    // Simular respuesta automática
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages.add({
          "fromMe": false,
          "text": "Recibido 👍",
          "time": _getCurrentTime(),
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _getCurrentTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
  }
}
