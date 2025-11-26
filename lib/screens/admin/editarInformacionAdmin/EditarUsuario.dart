import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/Camera.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';

class EditarUsuario extends StatefulWidget {
  final AppUser user;

  const EditarUsuario({super.key, required this.user});

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState();
}

const List<String> _listaLugares = <String>[
  "Madrid",
  "Barcelona",
  "Sevilla",
  "Zaragoza",
  "Alicante",
];

class _EditarUsuarioState extends State<EditarUsuario> {
  late Genero? _generoSelecionado;
  late TextEditingController _nombreController;
  late TextEditingController _contrasenaController;
  late TextEditingController _repiteContrasenaController;
  late TextEditingController _edadController;
  String? photoPath;
  String? _lugarNacimiento;
  late bool _esAdmin;
  bool _ocultarContrasena = false;

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
    _esAdmin = widget.user.getIsAdmin == true;
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
          _esAdmin,
        );
        Navigator.pop(context, true); // true indica que se realizaron cambios
      } else {
        const snackBar = SnackBar(
          content: Text("Las contraseñas no son iguales"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text("Campos vacíos en nombre y contraseña"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: const Text("Editar Usuario"),
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
                      const Text("Tratamiento actual: "),
                      Text(
                        _generoSelecionado == Genero.Sr ? "Sr." : "Sra.",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 230, 14, 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("Cambiar a: "),
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
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _contrasenaController,
                    obscureText: _ocultarContrasena,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
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
                      labelText: "Repite Contraseña",
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
                  const Text("Cargar imagen:"),
                  if (photoPath != null)
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.file(File(photoPath!), fit: BoxFit.cover),
                    ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Galería"),
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
                    label: const Text("Cámara"),
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
                              color: const Color.fromARGB(255, 230, 14, 14),
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
                          ? "Edad"
                          : "Nueva edad",
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
                              color: const Color.fromARGB(255, 230, 14, 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: widget.user.getNacimiento == null
                          ? "Lugar de nacimiento"
                          : "Nuevo lugar de nacimiento",
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
              Row(
                children: [
                  const Text("Es administrador"),
                  Switch(
                    value: _esAdmin,
                    onChanged: (bool value) {
                      setState(() {
                        _esAdmin = value;
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
                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
