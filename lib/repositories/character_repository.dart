import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rick_and_morty_flutter/models/character_model.dart';

class CharacterRepository {
  final String apiUrl = "https://rickandmortyapi.com/api/character";
  final http.Client client;

  int _currentPage = 1;
  bool _hasNextPage = true;

  CharacterRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Character>> getCharacters({bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _hasNextPage = true;
    }

    if (!_hasNextPage) {
      return [];
    }

    final response = await client.get(Uri.parse('$apiUrl?page=$_currentPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Character> characters = (data['results'] as List)
          .map((i) => Character.fromJson(i))
          .toList();
      _currentPage++;
      _hasNextPage = data['info']['next'] != null;
      return characters;
    } else if (response.statusCode == 404) {
      _hasNextPage = false;
      return [];
    } else {
      throw Exception('Error loading characters');
    }
  }

  Future<List<Character>> searchCharacters(String query) async {
    final response = await client.get(Uri.parse('$apiUrl?name=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Character> characters = (data['results'] as List)
          .map((i) => Character.fromJson(i))
          .toList();
      return characters;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Error searching for characters');
    }
  }
}
