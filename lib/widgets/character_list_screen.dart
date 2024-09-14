import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_flutter/blocs/character_bloc.dart';
import 'package:rick_and_morty_flutter/blocs/character_event.dart';
import 'package:rick_and_morty_flutter/blocs/character_state.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = CharacterBloc();
    _characterBloc.add(FetchCharacters());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      _characterBloc.add(FetchMoreCharacters());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _characterBloc.add(SearchCharacters(query));
    } else {
      _characterBloc.add(FetchCharacters());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _characterBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _characterBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Rick and Morty characters')),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  if (state is CharacterLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CharacterLoaded) {
                    if (state.characters.isEmpty) {
                      return Center(child: Text('No characters found'));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.characters.length
                          : state.characters.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.characters.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          final character = state.characters[index];
                          return ListTile(
                            leading: Image.network(character.image),
                            title: Text(character.name),
                            subtitle:
                            Text('${character.status} - ${character.species}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CharacterDetailScreen(
                                    character: character,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  } else if (state is CharacterError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search character',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          _onSearchChanged();
        },
      ),
    );
  }
}
