import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_flutter/models/character_model.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final bool hasReachedMax;

  const CharacterLoaded({
    required this.characters,
    this.hasReachedMax = false,
  });

  CharacterLoaded copyWith({
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [characters, hasReachedMax];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
