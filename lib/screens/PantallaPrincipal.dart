import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/controllers/LoginController.dart';
import 'package:flutter_application/screens/PantallaSecundaria.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  String nombre = "";
  String _contrasena = "";
  void _PantallaRegistros() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaRegistros()),
    );
  }

  void _validar() {
    if (nombre.isNotEmpty && _contrasena.isNotEmpty) {
      if (loginController.validarUsuario(nombre, _contrasena) == true) {
        usuarioActual = loginController.getUsuario(nombre);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PantallaSecundaria()),
        );
      } else {
        print("Usuario o contraseña incorrectos");
        const snackBar = SnackBar(
          content: Text("Usuario o contraseña incorrectos"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("El campo esta vacio");
      const snackBar = SnackBar(content: Text("El campo esta vacio"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 180, 228, 1),
        title: Text("Pantalla Principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: Image.asset(
                'assets/images/Logo.png',
                width: 400,
                height: 400,
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  nombre = value;
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  //labelText: "Contraseña",
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _contrasena = value,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: const Color.fromARGB(255, 187, 228, 247),
              ),
              onPressed: _validar,
              child: Text("Login", style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: const Color.fromARGB(255, 187, 228, 247),
              ),
              onPressed: _PantallaRegistros,
              child: Text("Registrate", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
