// To parse this JSON data, do
//
//     final UniversityModel = UniversityModelFromJson(jsonString);

import 'dart:convert';

List<UniversityModel> universityModelFromJson(String str) =>
    List<UniversityModel>.from(
        json.decode(str).map((x) => UniversityModel.fromJson(x)));

String universityModelToJson(List<UniversityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityModel {
  UniversityModel(
      {required this.alphaTwoCode,
      required this.domains,
      required this.country,
      required this.stateProvince,
      required this.webPages,
      required this.name,
      this.image});

  String alphaTwoCode;
  List<String> domains;
  String country;
  dynamic stateProvince;
  List<String> webPages;
  String name;
  String? image;

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      UniversityModel(
        alphaTwoCode: json['alpha_two_code'],
        domains: List<String>.from(json['domains'].map((x) => x)),
        country: json['country'],
        stateProvince: json['state-province'],
        webPages: List<String>.from(json['web_pages'].map((x) => x)),
        name: json['name'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'alpha_two_code': alphaTwoCode,
        'domains': List<dynamic>.from(domains.map((x) => x)),
        'country': country,
        'state-province': stateProvince,
        'web_pages': List<dynamic>.from(webPages.map((x) => x)),
        'name': name,
        'image': image,
      };
}
