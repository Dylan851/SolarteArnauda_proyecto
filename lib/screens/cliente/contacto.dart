import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class contacto extends StatelessWidget {
  final AppUser user;
  const contacto({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final usuario = usuarioActual;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text(l10n.contactTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: buildLanguageDropdown(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FOTO DE PERFIL
            Image.asset(
              usuario?.photoPath ?? 'assets/images/LogoUsuario.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 20),

            // NOMBRE DEL USUARIO
            Text(
              user.getName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // DATOS
            infoItem("${l10n.password}:", user.getPassword),
            infoItem(
              "${l10n.gender}",
              user.getGenero != null
                  ? usuario!.genero.toString().split('.').last
                  : l10n.noData,
            ),
            infoItem("${l10n.age}:", user.getEdad.toString()),
            infoItem(
              "${l10n.placeOfBirth}:",
              user.getNacimiento ?? l10n.noData,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.back),
            ),
          ],
        ),
      ),
    );
  }

  // FUNCION SIMPLE PARA MOSTRAR TEXTO BONITO
  Widget infoItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 5),
          Text(valor, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
