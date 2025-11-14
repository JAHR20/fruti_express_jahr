import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileModal extends StatefulWidget {
  final VoidCallback onLogout;

  const UserProfileModal({Key? key, required this.onLogout}) : super(key: key);

  @override
  State<UserProfileModal> createState() => _UserProfileModalState();
}

class _UserProfileModalState extends State<UserProfileModal> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final perfil = authProvider.perfilLocal;

    if (perfil == null) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: Text("Error: No se pudo cargar el perfil.")),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Perfil de Usuario',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _openCamera,
            child: Center(
              child: Stack(
                children: [
                  _imageFile == null
                      ? const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.deepPurple,
                          child: Icon(
                            Icons.person_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(_imageFile!),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toca el ícono para cambiar tu foto',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.deepPurple),
            title: Text(
              "${perfil.nombres} ${perfil.apellidoPaterno} ${perfil.apellidoMaterno ?? ''}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email_outlined, color: Colors.deepPurple),
            title: Text(perfil.email),
          ),
          ListTile(
            leading: Icon(Icons.phone_outlined, color: Colors.deepPurple),
            title: Text(perfil.telefono),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: widget.onLogout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
