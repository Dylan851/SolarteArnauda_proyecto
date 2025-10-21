import 'package:flutter_application/models/User.dart';

class Logicausuarios {
  static final List<User> _ListaUsuarios = [
    User(name: "admin", password: "admin"),
  ];

  //metodo para añadir usuarios
  static void anadirUsuarios(User usuarios) {
    _ListaUsuarios.add(usuarios);
  }

  //metodo para obtener la lista de usuarios
  static List<User> getListaUsuarios() {
    return _ListaUsuarios;
  }
}
