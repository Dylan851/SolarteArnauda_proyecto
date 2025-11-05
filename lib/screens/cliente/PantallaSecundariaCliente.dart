import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
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
                itemCount: Loginproductos.recorrerProductos().length,
                itemBuilder: (context, index) {
                  // Accedemos a cada detalle del producto
                  String detalleProducto =
                      Loginproductos.recorrerProductos()[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(detalleProducto),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
