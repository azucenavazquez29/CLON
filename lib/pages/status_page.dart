import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  File? _imageFile;
  File? _videoFile;
  VideoPlayerController? _videoController;

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> pickImage({ImageSource source = ImageSource.camera}) async {
    await requestPermissions();
    final picker = ImagePicker();
    final XFile? selected = await picker.pickImage(source: source);

    if (selected == null) return;

    setState(() {
      _imageFile = File(selected.path);
      _videoFile = null;
      _videoController?.dispose();
      _videoController = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Estado de foto actualizado")));
  }

  Future<void> pickVideo({ImageSource source = ImageSource.camera}) async {
    await requestPermissions();
    final picker = ImagePicker();
    final XFile? selected = await picker.pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 20),
    );

    if (selected == null) return;

    _videoFile = File(selected.path);

    _videoController = VideoPlayerController.file(_videoFile!)
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play();
      });

    setState(() {
      _imageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Estado de video actualizado")),
    );
  }

  Widget _preview() {
    if (_imageFile != null) {
      return Image.file(_imageFile!, fit: BoxFit.cover);
    }

    if (_videoFile != null && _videoController != null) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          VideoProgressIndicator(_videoController!, allowScrubbing: true),
          IconButton(
            icon: Icon(
              _videoController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              setState(() {
                _videoController!.value.isPlaying
                    ? _videoController!.pause()
                    : _videoController!.play();
              });
            },
          ),
        ],
      );
    }

    return const Center(
      child: Text(
        "Toca la cámara para crear un estado",
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF007849),
        title: const Text("Estados"),
        elevation: 0,
      ),

      body: Column(
        children: [
          /// === MI ESTADO ===
          ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage("assets/images/user1.jpg")
                          as ImageProvider,
              ),
            ),
            title: const Text("Mi estado"),
            subtitle: Text(
              _imageFile == null && _videoFile == null
                  ? "Toca la cámara para agregar un estado"
                  : "Estado actualizado",
            ),
            onTap: () {},
          ),

          const Divider(),

          /// === PREVIEW DE FOTO/VIDEO ===
          Expanded(
            child: Container(color: Colors.black12, child: _preview()),
          ),
        ],
      ),

      /// === BOTONES FLOTANTES AL ESTILO WHATSAPP ===
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "video",
            backgroundColor: const Color(0xFF003366),
            onPressed: () => pickVideo(source: ImageSource.camera),
            child: const Icon(Icons.videocam),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "image",
            backgroundColor: const Color(0xFF007849),
            onPressed: () => pickImage(source: ImageSource.camera),
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
