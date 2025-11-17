import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';

class contactoCliente extends StatefulWidget {
  const contactoCliente({super.key});

  @override
  State<contactoCliente> createState() => _contactoClienteState();
}

class _contactoClienteState extends State<contactoCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
        title: Text("Contacto Cliente"),
      ),
      body: Container(
        child: Center(
          child: Row(
            children: [
              //Image.asset('assets\images\ronnieColeman.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nombre: ${usuarioActual?.name ?? 'No logueado'}"),
                  Text(
                    "Contraseña: ${usuarioActual?.password ?? 'No logueado'}",
                  ),
                  Text("Genero: ${usuarioActual?.genero ?? 'No hay datos'}"),
                  Text("Edad: ${usuarioActual?.edad ?? 'No hay datos'}"),
                  Text(
                    "Lugar de nacimiento: ${usuarioActual?.nacimiento ?? 'No hay datos'}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
