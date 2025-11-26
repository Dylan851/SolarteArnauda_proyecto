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

class EditarUsuarioCliente extends StatefulWidget {
  final AppUser user;

  const EditarUsuarioCliente({super.key, required this.user});

  @override
  State<EditarUsuarioCliente> createState() => _EditarUsuarioClienteState();
}

const List<String> _listaLugares = <String>[
  "Madrid",
  "Barcelona",
  "Sevilla",
  "Zaragoza",
  "Alicante",
];

class _EditarUsuarioClienteState extends State<EditarUsuarioCliente> {
  late Genero? _generoSelecionado;
  late TextEditingController _nombreController;
  late TextEditingController _contrasenaController;
  late TextEditingController _repiteContrasenaController;
  late TextEditingController _edadController;
  String? photoPath;
  String? _lugarNacimiento;
  bool _ocultarContrasena = true;

  @override
  void initState() {
    super.initState();
    // Inicializar con los datos del usuario
    _generoSelecionado = widget.user.getGenero;
    _nombreController = TextEditingController(text: widget.user.getName);
    _contrasenaController = TextEditingController(
      text: widget.user.getPassword,
    );
    _repiteContrasenaController = TextEditingController(
      text: widget.user.getPassword,
    );
    _edadController = TextEditingController(
      text: widget.user.getEdad?.toString() ?? '',
    );
    photoPath = widget.user.getPhotoPath;
    _lugarNacimiento = widget.user.getNacimiento;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _contrasenaController.dispose();
    _repiteContrasenaController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_nombreController.text.isNotEmpty &&
        _contrasenaController.text.isNotEmpty &&
        _repiteContrasenaController.text.isNotEmpty) {
      if (_contrasenaController.text == _repiteContrasenaController.text) {
        // Actualizar el usuario
        LogicaUsuarios.actualizarUsuario(
          widget.user.getName,
          _generoSelecionado,
          _nombreController.text,
          _contrasenaController.text,
          int.tryParse(_edadController.text),
          photoPath,
          _lugarNacimiento,
          widget.user.getIsAdmin,
        );

        // Actualizar el usuario actual en memoria
        final updatedUser = LogicaUsuarios.getListaUsuarios().firstWhere(
          (u) => u.name == _nombreController.text,
        );

        usuarioActual = updatedUser;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.userUpdatedSuccessfully,
            ),
          ),
        );

        // Devolver el usuario actualizado
        Navigator.pop(context, updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.passwordsNotEqual),
          ),
        );
      }
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
        title: Text(l10n.editUserTitle),
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
                      Text("${l10n.treatment.replaceAll(':', '')} actual: "),
                      Text(
                        _generoSelecionado == Genero.Sr ? l10n.mr : l10n.mrs,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Appcolor.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
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
              Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: l10n.username,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _contrasenaController,
                    obscureText: _ocultarContrasena,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _ocultarContrasena
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _ocultarContrasena = !_ocultarContrasena;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _repiteContrasenaController,
                    obscureText: _ocultarContrasena,
                    decoration: InputDecoration(
                      labelText: l10n.repeatPassword,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _ocultarContrasena
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _ocultarContrasena = !_ocultarContrasena;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.user.getEdad != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Text("Edad actual: "),
                          Text(
                            "${widget.user.getEdad} años",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Appcolor.backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  TextFormField(
                    controller: _edadController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.user.getEdad == null
                          ? l10n.age
                          : "${l10n.age}",
                      border: const OutlineInputBorder(),
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.user.getNacimiento != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Text("Lugar de nacimiento actual: "),
                          Text(
                            widget.user.getNacimiento!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Appcolor.backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: widget.user.getNacimiento == null
                          ? l10n.placeOfBirth
                          : l10n.placeOfBirth,
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
                ],
              ),
              const SizedBox(height: 15),
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
