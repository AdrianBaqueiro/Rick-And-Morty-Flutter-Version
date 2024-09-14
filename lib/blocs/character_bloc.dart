import 'package:flutter_bloc/flutter_bloc.dart';
import '../injection.dart';
import 'character_event.dart';
import 'character_state.dart';
import 'package:rick_and_morty_flutter/repositories/character_repository.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository = getIt<CharacterRepository>();

  CharacterBloc() : super(CharacterInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<FetchMoreCharacters>(_onFetchMoreCharacters);
    on<SearchCharacters>(_onSearchCharacters);
  }

  void _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      final characters = await repository.getCharacters(reset: true);
      emit(CharacterLoaded(characters: characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }

  void _onFetchMoreCharacters(
      FetchMoreCharacters event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      if (!currentState.hasReachedMax) {
        try {
          final characters = await repository.getCharacters();
          if (characters.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            emit(CharacterLoaded(
              characters: currentState.characters + characters,
              hasReachedMax: false,
            ));
          }
        } catch (e) {
          emit(CharacterError(e.toString()));
        }
      }
    }
  }

  void _onSearchCharacters(
      SearchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      final characters = await repository.searchCharacters(event.query);
      emit(CharacterLoaded(characters: characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }
}
