import 'package:flutter_application/screens/PantallaRegistros.dart';

class User {
  final String name;
  final String password;
  Genero? genero;
  int? edad;
  String? nacimiento;
  String? photoPath;
  User({
    required this.name,
    required this.password,
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
}
