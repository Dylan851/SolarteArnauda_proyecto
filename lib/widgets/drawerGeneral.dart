import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
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
            color: Appcolor.backgroundColor,
            child: DrawerHeader(child: Row(children: [Text("Menu")])),
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text("Pantalla Principal"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Mi perfil"),
            onTap: () {
              Navigator.pop(context);
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PantallaPrincipal()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
