import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/Camera.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class EditarUsuarioGoogle extends StatefulWidget {
  final AppUser user;

  const EditarUsuarioGoogle({super.key, required this.user});

  @override
  State<EditarUsuarioGoogle> createState() => _EditarUsuarioGoogleState();
}

const List<String> _listaLugares = <String>[
  "Madrid",
  "Barcelona",
  "Sevilla",
  "Zaragoza",
  "Alicante",
];

class _EditarUsuarioGoogleState extends State<EditarUsuarioGoogle> {
  late Genero? _generoSelecionado;
  late TextEditingController _nombreController;
  late TextEditingController _edadController;
  String? photoPath;
  String? _lugarNacimiento;

  @override
  void initState() {
    super.initState();
    // Todos los campos vacíos para usuarios Google
    _generoSelecionado = Genero.Sr;
    _nombreController = TextEditingController();
    _edadController = TextEditingController();
    photoPath = null;
    _lugarNacimiento = null;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_nombreController.text.isNotEmpty) {
      final newUser = AppUser(
        name: _nombreController.text,
        password: widget.user.getPassword ?? '',
        genero: _generoSelecionado,
        edad: int.tryParse(_edadController.text),
        photoPath: photoPath,
        nacimiento: _lugarNacimiento,
        isAdmin: false,
      );

      LogicaUsuarios.anadirUsuarios(newUser);
      usuarioActual = newUser;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.userUpdatedSuccessfully),
        ),
      );

      Navigator.pop(context, newUser);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.fieldsEmptyNamePassword),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text("${l10n.editUserTitle} (Google)"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: buildLanguageDropdown(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${l10n.treatment.replaceAll(':', '')} ${l10n.mr}/${l10n.mrs}",
                      ),
                      const SizedBox(width: 20),
                      Radio<Genero>(
                        value: Genero.Sr,
                        groupValue: _generoSelecionado,
                        onChanged: (Genero? value) {
                          setState(() {
                            _generoSelecionado = value;
                          });
                        },
                      ),
                      const Text(" Sr."),
                      const SizedBox(width: 20),
                      Radio<Genero>(
                        value: Genero.Sra,
                        groupValue: _generoSelecionado,
                        onChanged: (Genero? value) {
                          setState(() {
                            _generoSelecionado = value;
                          });
                        },
                      ),
                      const Text(" Sra."),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: l10n.username,
                  border: const OutlineInputBorder(),
                  hintText: "Completa tu nombre",
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(l10n.loadImage),
                  if (photoPath != null)
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.file(File(photoPath!), fit: BoxFit.cover),
                    ),
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
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.age,
                  border: const OutlineInputBorder(),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
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
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: _guardar,
                child: Text(
                  l10n.save,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.cancel,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
