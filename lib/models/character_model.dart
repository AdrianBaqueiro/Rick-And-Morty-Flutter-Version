import 'dart:convert';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String origin;
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      origin: json['origin']['name'] ?? '',
      location: json['location']['name'] ?? '',
    );
  }
}

List<Character> charactersFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Character>.from(
    jsonData['results'].map((x) => Character.fromJson(x)),
  );
}
