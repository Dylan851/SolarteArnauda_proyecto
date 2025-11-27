import 'package:flutter_application/screens/PantallaRegistros.dart';

// Modelo de usuario de la aplicación
class AppUser {
  final String name;
  final String password;
  Genero? genero;
  int? edad;
  String? nacimiento;
  String? photoPath;
  bool isAdmin;
  bool isBlocked = false;

  AppUser({
    required this.name,
    required this.password,
    this.isAdmin = false,
    this.genero,
    this.edad,
    this.nacimiento,
    this.photoPath,
  });

  // Getters para acceder a los atributos
  String get getName => name;
  String get getPassword => password;
  Genero? get getGenero => genero;
  int? get getEdad => edad;
  String? get getNacimiento => nacimiento;
  String? get getPhotoPath => photoPath;
  bool get getIsAdmin => isAdmin;
  bool get getIsBlocked => isBlocked;
}
