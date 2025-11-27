import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/config/utils/Camera.dart';
import 'package:flutter_application/controllers/LoginController.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

enum Genero { Sr, Sra }

// Pantalla de registro de nuevos usuarios
class PantallaRegistros extends StatefulWidget {
  const PantallaRegistros({super.key});

  @override
  State<PantallaRegistros> createState() => _PantallaRegistrosState();
}

const List<String> _listaLugares = <String>[
  "Madrid",
  "Barcelona",
  "Sevilla",
  "Zaragoza",
  "Alicante",
];

class _PantallaRegistrosState extends State<PantallaRegistros> {
  Genero? generoSelecionado = Genero.Sr;
  String _nombre = "";
  String _contrasena = "";
  String _repiteContrasena = "";
  int? _edad;
  String? photoPath;
  String? _lugarNacimiento;
  bool _aceptaTerminos = false;
  void _aceptar() {
    if (_nombre.isNotEmpty &&
        _contrasena.isNotEmpty &&
        _repiteContrasena.isNotEmpty) {
      if (_contrasena == _repiteContrasena) {
        if (_aceptaTerminos == true) {
          loginController.newUsuario(
            generoSelecionado,
            _nombre,
            _contrasena,
            _edad,
            photoPath,
            _lugarNacimiento,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.mustAcceptTerms)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.passwordsNotEqual)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.fieldsEmptyNamePassword)),
      );
    }
  }

  void _cancelar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text(l10n.register),
        actions: [Padding(padding: const EdgeInsets.only(right: 8), child: buildLanguageDropdown())],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text("${l10n.treatment} "),
                const SizedBox(width: 20),
                Radio<Genero>(
                  value: Genero.Sr,
                  groupValue: generoSelecionado,
                  onChanged: (Genero? value) {
                    setState(() {
                      generoSelecionado = value;
                    });
                  },
                ),
                Text(" ${l10n.mr}"),
                const SizedBox(width: 20),
                Radio<Genero>(
                  value: Genero.Sra,
                  groupValue: generoSelecionado,
                  onChanged: (Genero? value) {
                    setState(() {
                      generoSelecionado = value;
                    });
                  },
                ),
                Text(" ${l10n.mrs}"),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.username,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _nombre = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => _contrasena = value,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.repeatPassword,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => _repiteContrasena = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(l10n.loadImage),
                photoPath != null
                    ? Image(
                        image: FileImage(File(photoPath!)),
                        fit: BoxFit.fill,
                      )
                    : Container(),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: Text(l10n.gallery),
                  onPressed: () async {
                    final path = await CameraGalleryService().selectPhoto();
                    if (path == null) return;
                    setState(() {
                      photoPath = path;
                    });
                  },
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: Text(l10n.camera),
                  onPressed: () async {
                    final path = await CameraGalleryService().takePhoto();
                    if (path == null) return;
                    setState(() {
                      photoPath = path;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.age,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _edad = int.tryParse(value);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: l10n.placeOfBirth,
                  border: const OutlineInputBorder(),
                ),
                value: _lugarNacimiento,
                items: _listaLugares.map((String lugar) {
                  return DropdownMenuItem(value: lugar, child: Text(lugar));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _lugarNacimiento = value;
                  });
                },
              ),
            ),
            Row(
              children: [
                Text(l10n.acceptTerms),
                Checkbox(
                  value: _aceptaTerminos,
                  onChanged: (bool? value) {
                    setState(() {
                      _aceptaTerminos = value ?? true;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Appcolor.backgroundColor,
              ),
              onPressed: _aceptar,
              child: Text(l10n.accept, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: Appcolor.backgroundColor,
              ),
              onPressed: _cancelar,
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
