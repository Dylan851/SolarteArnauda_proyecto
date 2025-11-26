import 'package:flutter_application/screens/PantallaRegistros.dart';

class AppUser {
  final String name;
  final String password;
  Genero? genero;
  int? edad;
  String? nacimiento;
  String? photoPath;
  bool isAdmin;
  AppUser({
    required this.name,
    required this.password,
    this.isAdmin = false,
    this.genero,
    this.edad,
    this.nacimiento,
    this.photoPath,
  });
  String get getName => name;
  String get getPassword => password;
  Genero? get getGenero => genero;
  int? get getEdad => edad;
  String? get getNacimiento => nacimiento;
  String? get getPhotoPath => photoPath;
  bool get getIsAdmin => isAdmin;
  bool isBlocked = false;
  bool get getIsBlocked => isBlocked;
}
