import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/cliente/editarUsuarioCliente.dart';

class PerfilPageWidget extends StatefulWidget {
  final VoidCallback onContacto;
  final VoidCallback onEditarUsuario;

  const PerfilPageWidget({
    super.key,
    required this.onContacto,
    required this.onEditarUsuario,
  });

  @override
  State<PerfilPageWidget> createState() => _PerfilPageWidgetState();
}

class _PerfilPageWidgetState extends State<PerfilPageWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Detectar si es usuario de Google
    final isGoogleUser =
        usuarioActual?.getPassword == null ||
        (usuarioActual?.getPassword?.isEmpty ?? true);

    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: widget.onContacto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.contact_mail, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      l10n.contact,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: isGoogleUser ? null : _editarUsuarioCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isGoogleUser
                      ? Colors.grey
                      : Appcolor.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      isGoogleUser
                          ? "${l10n.editUser} (No disponible)"
                          : l10n.editUser,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editarUsuarioCliente() async {
    final updatedUser = await Navigator.push<AppUser>(
      context,
      MaterialPageRoute(
        builder: (context) => EditarUsuarioCliente(user: usuarioActual!),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        usuarioActual = updatedUser;
      });
    }
  }
}
