import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';

class GestionUsuarios extends StatelessWidget {
  const GestionUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    final users = LogicaUsuarios.getListaUsuarios();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              leading: Builder(
                builder: (context) {
                  final path = user.getPhotoPath;
                  ImageProvider<Object>? img;
                  if (path != null && path.isNotEmpty) {
                    if (path.startsWith('http')) {
                      img = NetworkImage(path);
                    } else if (path.startsWith('assets/')) {
                      img = AssetImage(path);
                    } else {
                      img = FileImage(File(path));
                    }
                  }

                  return CircleAvatar(
                    backgroundImage: img,
                    child: img == null ? Text('${index + 1}') : null,
                  );
                },
              ),
              title: Text(user.getName),
              subtitle: Text(user.getPassword),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionado: ${user.getName}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
