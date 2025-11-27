import 'package:flutter_application/screens/PantallaRegistros.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';
import 'package:flutter_application/models/User.dart';

// Controlador para manejar el login y registro de usuarios
class loginController {
  // Valida las credenciales del usuario
  static bool validarUsuario(String nombreIngresado, String passwordIngresado) {
    for (AppUser user in LogicaUsuarios.getListaUsuarios()) {
      if (user.getName == nombreIngresado &&
          user.getPassword == passwordIngresado) {
        return true;
      }
    }
    return false;
  }

  // Busca un usuario por su nombre
  static AppUser? getUsuario(String nombre) {
    for (var usuario in LogicaUsuarios.getListaUsuarios()) {
      if (usuario.name == nombre) {
        return usuario;
      }
    }
    return null;
  }

  // Crea un nuevo usuario con los datos proporcionados
  static void newUsuario(
    Genero? generoIngresado,
    String nombreIngresado,
    String passwordIngresado,
    int? edad,
    String? photoPath,
    String? lugarNacimientoIngersado, [
    bool isAdmin = false,
  ]) {
    LogicaUsuarios.anadirUsuarios(
      AppUser(
        genero: generoIngresado,
        name: nombreIngresado,
        password: passwordIngresado,
        photoPath: photoPath,
        edad: edad,
        nacimiento: lugarNacimientoIngersado,
        isAdmin: isAdmin,
      ),
    );
  }
}
