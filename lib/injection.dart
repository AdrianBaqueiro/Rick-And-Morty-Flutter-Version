import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_flutter/repositories/character_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<CharacterRepository>(() => CharacterRepository());
}