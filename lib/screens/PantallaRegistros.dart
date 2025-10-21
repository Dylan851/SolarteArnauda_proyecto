import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/config/utils/Camera.dart';
import 'package:flutter_application/controllers/LoginController.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';

enum Genero { Sr, Sra }

class PantallaRegistros extends StatefulWidget {
  const PantallaRegistros({super.key});

  @override
  State<PantallaRegistros> createState() => _PantallaRegistrosState();
}

const List<String> _listaLugares = <String>[
  "Madrid",
  "barcelona",
  "Sevilla",
  "Zaragoza",
];

class _PantallaRegistrosState extends State<PantallaRegistros> {
  Genero? _generoSelecionado = Genero.Sr;
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
            _generoSelecionado,
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
          const snackBar = SnackBar(
            content: Text("Acepta terminos y condiciones"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        const snackBar = SnackBar(
          content: Text("Las contraseñas no son iguales"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text("Campos vacios en nombre y contraseña"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 180, 228, 1),
        title: Text("Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Tratamiento: "),
                SizedBox(width: 20),
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
                SizedBox(width: 20),
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
            SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _nombre = value;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _contrasena = value,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Repite Contraseña",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _repiteContrasena = value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Cargar imagen:"),
                photoPath != null
                    ? Image(
                        image: FileImage(File(photoPath!)),
                        fit: BoxFit.fill,
                      )
                    : Container(),
                SizedBox(width: 20),
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
            SizedBox(height: 20),
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Edad",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _edad = int.tryParse(value);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Lugar de nacimiento",
                  border: OutlineInputBorder(),
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
                const Text("Acepto los terminos y condiciones"),
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
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: const Color.fromARGB(255, 187, 228, 247),
              ),
              onPressed: _aceptar,
              child: Text("Aceptar", style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: const Color.fromARGB(255, 187, 228, 247),
              ),
              onPressed: _cancelar,
              child: Text("Cancelar", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
