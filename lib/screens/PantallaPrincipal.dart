import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/config/utils/music.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/controllers/LoginController.dart';
import 'package:flutter_application/screens/cliente/PantallaSecundariaCliente.dart';
import 'package:flutter_application/screens/admin/AdminHome.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

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

  void _validar() async {
    if (nombre.isNotEmpty && _contrasena.isNotEmpty) {
      final usuario = loginController.getUsuario(nombre);
      if (usuario != null &&
          usuario.getPassword == _contrasena &&
          usuario.getIsAdmin == true) {
        await Music.playMusic(); // Play music on admin login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminHome()),
        );
        return;
      }

      if (loginController.validarUsuario(nombre, _contrasena) == true) {
        usuarioActual = usuario ?? loginController.getUsuario(nombre);
        await Music.playMusic(); // Play music on client login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PantallaSecundaria()),
        );
      } else {
        print("Usuario o contraseña incorrectos");
        // ignore: unused_local_variable
        const snackBar = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.invalidCredentials),
          ),
        );
      }
    } else {
      print("El campo esta vacio");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.fieldEmpty)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolor.backgroundColor,
          title: Text(l10n.mainScreenTitle),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: buildLanguageDropdown(),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/ronnieColeman.png',
                  width: 400,
                  height: 400,
                ),
              ),
              SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: l10n.username,
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
                    labelText: l10n.password,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _contrasena = value,
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 40),
                  backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                ),
                onPressed: _validar,
                child: Text(
                  l10n.login,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 40),
                  backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                ),
                onPressed: _PantallaRegistros,
                child: Text(
                  l10n.register,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 40),
                  backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController usernameController =
                          TextEditingController();

                      return AlertDialog(
                        title: Text(
                          l10n.recoverPassword,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        content: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: l10n.username,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(l10n.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              if (usernameController.text.isEmpty) {
                                print(l10n.fieldEmpty);
                                return;
                              } else {
                                var usuario = loginController.getUsuario(
                                  usernameController.text,
                                );
                                if (usuario == null) {
                                  print('El nombre de usuario no existe.');
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${l10n.passwordRecovered}${usuario.getPassword}',
                                    ),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text(l10n.accept),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  l10n.recoverPassword,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
