import 'package:flutter/material.dart';
import 'package:flutter_application/screens/MiPerfil.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';

class drawerGeneral extends StatefulWidget {
  const drawerGeneral({super.key});

  @override
  State<drawerGeneral> createState() => _drawerGeneralState();
}

class _drawerGeneralState extends State<drawerGeneral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 60,
            color: Color.fromRGBO(61, 180, 228, 1),
            child: DrawerHeader(child: Row(children: [Text("Menu")])),
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text("Pantalla Principal"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaPrincipal()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Mi perfil"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Miperfil()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaPrincipal()),
              );
            },
          ),
        ],
      ),
    );
  }
}
