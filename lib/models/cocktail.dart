// To parse this JSON data, do
//
//     final cocktail = cocktailFromMap(jsonString);

import 'dart:convert';

class Cocktail {
  Cocktail({
    this.strDrink,
    this.strDrinkThumb,
    this.idDrink,
  });

  String strDrink;
  String strDrinkThumb;
  String idDrink;

  factory Cocktail.fromJson(String str) => Cocktail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cocktail.fromMap(Map<String, dynamic> json) => Cocktail(
        strDrink: json["strDrink"],
        strDrinkThumb: json["strDrinkThumb"],
        idDrink: json["idDrink"],
      );

  Map<String, dynamic> toMap() => {
        "strDrink": strDrink,
        "strDrinkThumb": strDrinkThumb,
        "idDrink": idDrink,
      };
}
