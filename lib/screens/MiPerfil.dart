import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class Miperfil extends StatefulWidget {
  const Miperfil({super.key});

  @override
  State<Miperfil> createState() => _MiperfilState();
}

class _MiperfilState extends State<Miperfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerGeneral(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 180, 228, 1),
        title: Text("Mi perfil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nombre: ${usuarioActual?.name ?? 'No logueado'}"),
            Text("Contraseña: ${usuarioActual?.password ?? 'No logueado'}"),
            Text("Genero: ${usuarioActual?.genero ?? 'No hay datos'}"),
            Text("Edad: ${usuarioActual?.edad ?? 'No hay datos'}"),
            Text(
              "Lugar de nacimiento: ${usuarioActual?.nacimiento ?? 'No hay datos'}",
            ),
          ],
        ),
      ),
    );
  }
}
