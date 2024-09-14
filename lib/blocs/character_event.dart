abstract class CharacterEvent {}

class FetchCharacters extends CharacterEvent {}

class FetchMoreCharacters extends CharacterEvent {}

class SearchCharacters extends CharacterEvent {
  final String query;
  SearchCharacters(this.query);
}