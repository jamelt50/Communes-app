import 'package:communes/classes/point.dart';

class City {
  final String nom;
  final String code;
  final String codeDepartement;
  final String codeRegion;
  final List<dynamic> codesPostaux;
  final Point centre;
  final int population;


  const City({
    required this.nom,
    required this.code,
    required this.codeDepartement,
    required this.codeRegion,
    required this.codesPostaux,
    required this.population,
    required this.centre,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      nom: json['nom'],
      code: json['code'],
      codeDepartement: json['codeDepartement'],
      codeRegion: json['codeRegion'],
      centre: Point.fromJson(json['centre']) ,
      codesPostaux: json['codesPostaux'],
      population: json['population'],
    );
  }
}