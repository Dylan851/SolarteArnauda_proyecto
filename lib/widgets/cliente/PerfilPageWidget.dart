import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/l10n/app_localizations.dart';

class PerfilPageWidget extends StatelessWidget {
  final VoidCallback onContacto;
  final VoidCallback onEditarUsuario;

  const PerfilPageWidget({
    super.key,
    required this.onContacto,
    required this.onEditarUsuario,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: onContacto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.contact_mail, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(l10n.contact, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: onEditarUsuario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(l10n.editUser, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
