import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/models/character_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  CharacterDetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(character.image),
            SizedBox(height: 16),
            _buildDetailRow('Status', character.status),
            _buildDetailRow('Species', character.species),
            _buildDetailRow('Type', character.type.isNotEmpty ? character.type : 'N/A'),
            _buildDetailRow('Gender', character.gender),
            _buildDetailRow('Origin', character.origin),
            _buildDetailRow('Location', character.location),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
