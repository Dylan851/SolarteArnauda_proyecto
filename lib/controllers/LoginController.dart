import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';
import 'package:flutter_application/models/User.dart';

class loginController {
  static bool validarUsuario(String nombreIngresado, String passwordIngresado) {
    for (User user in Logicausuarios.getListaUsuarios()) {
      if (user.getName == nombreIngresado &&
          user.getPassword == passwordIngresado) {
        return true;
      }
    }
    return false;
  }

  static User? getUsuario(String nombre) {
    for (var usuario in Logicausuarios.getListaUsuarios()) {
      if (usuario.name == nombre) {
        return usuario;
      }
    }
    return null; // No se encontró
  }

  static void newUsuario(
    Genero? generoIngresado,
    String nombreIngresado,
    String passwordIngresado,
    int? edad,
    String? photoPath,
    String? lugarNacimientoIngersado,
  ) {
    Logicausuarios.anadirUsuarios(
      User(
        genero: generoIngresado,
        name: nombreIngresado,
        password: passwordIngresado,
        photoPath: photoPath,
        edad: edad,
        nacimiento: lugarNacimientoIngersado,
      ),
    );
  }
}
