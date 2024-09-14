import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_flutter/blocs/character_bloc.dart';
import 'package:rick_and_morty_flutter/blocs/character_event.dart';
import 'package:rick_and_morty_flutter/blocs/character_state.dart';
import 'package:rick_and_morty_flutter/repositories/character_repository.dart';
import 'package:rick_and_morty_flutter/models/character_model.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('CharacterBloc', () {
    late CharacterBloc characterBloc;
    final getIt = GetIt.instance;
    late MockCharacterRepository mockRepository;

    setUp(() {
      getIt.reset();
      getIt.registerLazySingleton<CharacterRepository>(() => mockRepository);

      mockRepository = MockCharacterRepository();
      characterBloc = CharacterBloc();
    });

    tearDown(() {
      characterBloc.close();
    });

    test('initial state is CharacterInitial', () {
      expect(characterBloc.state, CharacterInitial());
    });

    blocTest<CharacterBloc, CharacterState>(
      'emits [CharacterLoading, CharacterLoaded] when FetchCharacters is added',
      build: () {
        when(() => mockRepository.getCharacters(reset: true))
            .thenAnswer((_) async => [
          Character(
            id: 1,
            name: 'Rick Sanchez',
            status: 'Alive',
            species: 'Human',
            type: '',
            gender: 'Male',
            image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            origin: 'Earth (C-137)',
            location: 'Earth (Replacement Dimension)',
          ),
        ]);
        return characterBloc;
      },
      act: (bloc) => bloc.add(FetchCharacters()),
      expect: () => [
        CharacterLoading(),
        isA<CharacterLoaded>(),
      ],
    );

    blocTest<CharacterBloc, CharacterState>(
      'emits [CharacterLoading, CharacterError] when FetchCharacters fails',
      build: () {
        when(() => mockRepository.getCharacters(reset: true))
            .thenThrow(Exception('Error'));
        return characterBloc;
      },
      act: (bloc) => bloc.add(FetchCharacters()),
      expect: () => [
        CharacterLoading(),
        isA<CharacterError>(),
      ],
    );
  });
}
