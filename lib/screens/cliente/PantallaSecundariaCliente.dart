import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/widgets/buttonNavegatorBarGeneral.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
  // Navegar a Pantalla Principal
  void _pantallaPrincipal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerGeneral(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 180, 228, 1),
        title: Text("Bienvenido ${usuarioActual?.name}"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nombre: ${usuarioActual?.name}'),
                      subtitle: Text(
                        'Edad: ${usuarioActual?.edad ?? 'No especificada'}\n'
                        'Género: ${usuarioActual?.genero.toString().split('.').last ?? 'No especificado'}\n'
                        'Lugar de Nacimiento: ${usuarioActual?.nacimiento ?? 'No especificado'}',
                      ),
                    ),
                  );
                },
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
