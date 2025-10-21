import 'package:flutter/material.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
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
        title: Text("Pantalla Secundaria"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40),
                backgroundColor: const Color.fromARGB(255, 187, 228, 247),
              ),
              onPressed: _pantallaPrincipal,
              child: Text(
                "Pantalla principal",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
