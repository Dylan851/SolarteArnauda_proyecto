import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';

class LogicaUsuarios {
  static final List<User> _listaUsuarios = [
    User(name: "admin", password: "admin", isAdmin: true),
    User(name: "dilan", password: "dilan"),
    User(name: "miguel", password: "miguel"),
  ];

  static void anadirUsuarios(User usuario) {
    _listaUsuarios.add(usuario);
  }

  static void eliminarUsuario(String nombre) {
    _listaUsuarios.removeWhere((u) => u.name == nombre);
  }

  static void toggleBloqueoUsuario(String nombre) {
    for (var u in _listaUsuarios) {
      if (u.name == nombre) {
        u.isBlocked = !u.isBlocked;
        break;
      }
    }
  }

  static void actualizarUsuario(
    String nombreOriginal,
    Genero? genero,
    String nuevoNombre,
    String nuevaContrasena,
    int? edad,
    String? photoPath,
    String? lugarNacimiento,
    bool isAdmin,
  ) {
    final index = _listaUsuarios.indexWhere((u) => u.name == nombreOriginal);
    if (index != -1) {
      final wasBlocked = _listaUsuarios[index].isBlocked;
      _listaUsuarios[index] = User(
        name: nuevoNombre,
        password: nuevaContrasena,
        isAdmin: isAdmin,
        genero: genero,
        edad: edad,
        nacimiento: lugarNacimiento,
        photoPath: photoPath,
      );
      _listaUsuarios[index].isBlocked = wasBlocked;
    }
  }

  static List<User> getListaUsuarios() {
    return _listaUsuarios;
  }
}
