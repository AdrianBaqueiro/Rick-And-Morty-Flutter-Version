import 'package:flutter/material.dart';
import 'injection.dart';
import 'widgets/character_list_screen.dart';

void main() {
  setup();
  runApp(RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharacterListScreen(),
    );
  }
}