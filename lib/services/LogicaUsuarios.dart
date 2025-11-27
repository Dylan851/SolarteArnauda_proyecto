import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/PantallaRegistros.dart';

// Servicio que gestiona la lógica de usuarios en la aplicación
class LogicaUsuarios {
  // Lista local de usuarios registrados en el sistema
  static final List<AppUser> _listaUsuarios = [
    AppUser(name: "admin", password: "admin", isAdmin: true),
    AppUser(name: "dilan", password: "dilan"),
    AppUser(name: "miguel", password: "miguel"),
  ];

  // Añade un nuevo usuario a la lista
  static void anadirUsuarios(AppUser usuario) {
    _listaUsuarios.add(usuario);
  }

  // Elimina un usuario por su nombre (no permite eliminar el usuario admin)
  static void eliminarUsuario(String nombre) {
    // Proteger al usuario admin de ser eliminado
    if (nombre == "admin") {
      return;
    }
    _listaUsuarios.removeWhere((u) => u.name == nombre);
  }

  // Bloquea o desbloquea un usuario
  static void toggleBloqueoUsuario(String nombre) {
    for (var u in _listaUsuarios) {
      if (u.name == nombre) {
        u.isBlocked = !u.isBlocked;
        break;
      }
    }
  }

  // Actualiza los datos de un usuario existente
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
      _listaUsuarios[index] = AppUser(
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

  // Retorna la lista completa de usuarios
  static List<AppUser> getListaUsuarios() {
    return _listaUsuarios;
  }
}
