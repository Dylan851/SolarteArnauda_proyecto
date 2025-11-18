import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/models/User.dart';

class contactoCliente extends StatelessWidget {
  final User user;
  const contactoCliente({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final usuario = usuarioActual;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text("Contacto Cliente"),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // DATOS DEL USUARIO EN UNA COLUMNA
            infoItem("Contraseña:", user.getPassword),
            infoItem(
              "Género:",
              user.getGenero != null
                  ? usuario!.genero.toString().split('.').last
                  : "No hay datos",
            ),
            infoItem("Edad:", user.getEdad.toString()),
            infoItem(
              "Lugar de nacimiento:",
              user.getNacimiento ?? "No hay datos",
            ),

            SizedBox(height: 40),

            // BOTÓN VOLVER
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Volver"),
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
