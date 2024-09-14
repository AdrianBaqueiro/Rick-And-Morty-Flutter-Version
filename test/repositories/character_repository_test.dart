import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_flutter/repositories/character_repository.dart';
import 'package:rick_and_morty_flutter/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  group('CharacterRepository', () {
    late CharacterRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      repository = CharacterRepository(client: mockClient);
      registerFallbackValue(FakeUri());
    });

    test('getCharacters returns list of characters when response is successful', () async {
      final response = {
        'info': {'next': 'next_page'},
        'results': [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            'origin': {'name': 'Earth (C-137)'},
            'location': {'name': 'Earth (Replacement Dimension)'},
          }
        ],
      };

      when(() => mockClient.get(Uri.parse('https://rickandmortyapi.com/api/character?page=1')))
          .thenAnswer((_) async => http.Response(json.encode(response), 200));

      final characters = await repository.getCharacters(reset: true);

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
      expect(characters.first.name, 'Rick Sanchez');
    });

    test('getCharacters handles 404 by setting _hasNextPage to false and returning empty list', () async {
      when(() => mockClient.get(Uri.parse('https://rickandmortyapi.com/api/character?page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final characters = await repository.getCharacters(reset: true);

      expect(characters, isEmpty);

      final charactersNext = await repository.getCharacters();
      expect(charactersNext, isEmpty);
    });

    test('getCharacters continues to return empty list after 404 response', () async {
      when(() => mockClient.get(any())).thenAnswer((_) async => http.Response('Not Found', 404));

      await repository.getCharacters(reset: true);

      final charactersNext = await repository.getCharacters();
      expect(charactersNext, isEmpty);
    });

    test('getCharacters throws exception when response status code is neither 200 nor 404', () async {
      when(() => mockClient.get(any())).thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => repository.getCharacters(reset: true), throwsException);
    });

    test('searchCharacters returns list of characters when response is successful', () async {
      final response = {
        'info': {'next': null},
        'results': [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            'origin': {'name': 'Earth (C-137)'},
            'location': {'name': 'Earth (Replacement Dimension)'},
          }
        ],
      };

      when(() => mockClient.get(Uri.parse('https://rickandmortyapi.com/api/character?name=Rick')))
          .thenAnswer((_) async => http.Response(json.encode(response), 200));

      final characters = await repository.searchCharacters('Rick');

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
      expect(characters.first.name, 'Rick Sanchez');
    });

    test('searchCharacters returns empty list when response status code is 404', () async {
      when(() => mockClient.get(Uri.parse('https://rickandmortyapi.com/api/character?name=Unknown')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final characters = await repository.searchCharacters('Unknown');

      expect(characters, isEmpty);
    });

    test('searchCharacters throws exception when response status code is neither 200 nor 404', () async {
      when(() => mockClient.get(any())).thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => repository.searchCharacters('Error'), throwsException);
    });
  });
}
