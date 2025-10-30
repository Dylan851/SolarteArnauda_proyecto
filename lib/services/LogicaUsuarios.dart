import 'package:flutter_application/models/User.dart';

class LogicaUsuarios {
  static final List<User> _listaUsuarios = [
    User(name: "admin", password: "admin"),
    User(name: "dilan", password: "dilan"),
    User(name: "miguel", password: "miguel"),
  ];

  // método para añadir un usuario
  static void anadirUsuarios(User usuario) {
    _listaUsuarios.add(usuario);
  }

  // método para obtener la lista de usuarios
  static List<User> getListaUsuarios() {
    return _listaUsuarios;
  }
}
