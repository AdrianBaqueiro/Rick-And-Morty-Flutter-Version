import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/widgets/character_detail_screen.dart';
import 'package:rick_and_morty_flutter/models/character_model.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('CharacterDetailScreen', () {
    final character = Character(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      origin: 'Earth (C-137)',
      location: 'Earth (Replacement Dimension)',
    );

    testWidgets('displays character details correctly', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
          home: CharacterDetailScreen(character: character),
        ));

        expect(find.text('Rick Sanchez'), findsOneWidget);

        expect(find.text('Status: '), findsOneWidget);
        expect(find.text('Alive'), findsOneWidget);

        expect(find.text('Species: '), findsOneWidget);
        expect(find.text('Human'), findsOneWidget);

        expect(find.text('Type: '), findsOneWidget);
        expect(find.text('N/A'), findsOneWidget);

        expect(find.text('Gender: '), findsOneWidget);
        expect(find.text('Male'), findsOneWidget);

        expect(find.text('Origin: '), findsOneWidget);
        expect(find.text('Earth (C-137)'), findsOneWidget);

        expect(find.text('Location: '), findsOneWidget);
        expect(find.text('Earth (Replacement Dimension)'), findsOneWidget);

        expect(find.byType(Image), findsOneWidget);
      });
    });
  });
}
