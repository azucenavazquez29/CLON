// Archivo de perfil
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return; // usuario canceló

    setState(() {
      _imageFile = File(image.path);
    });
  }

  void saveProfileImage() {
    // Aquí envías al backend tu foto
    // uploadProfileImage(_imageFile!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Foto de perfil guardada correctamente")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil del Usuario"),
        backgroundColor: const Color(0xFF003366),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Foto del perfil
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey[300],
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : null,
                child: _imageFile == null
                    ? const Icon(Icons.person, size: 70, color: Colors.white)
                    : null,
              ),

              const SizedBox(height: 20),

              /// Botones para elegir foto
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo),
                    label: const Text("Galería"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF007849,
                      ), // verde institucional
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: () => pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Cámara"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007849),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// Información básica del perfil
              const Text(
                "Nombre: Usuario TecNM",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text("Carrera: Ingeniería en Sistemas"),
              const Text(
                "Estado: Disponible",
                style: TextStyle(color: Colors.green),
              ),

              const SizedBox(height: 25),

              if (_imageFile != null)
                ElevatedButton.icon(
                  onPressed: saveProfileImage,
                  icon: const Icon(Icons.upload),
                  label: const Text("Guardar foto"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF003366,
                    ), // azul institucional
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
