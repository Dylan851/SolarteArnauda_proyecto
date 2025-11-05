import 'package:flutter_application/models/User.dart';

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

  static List<User> getListaUsuarios() {
    return _listaUsuarios;
  }
}
