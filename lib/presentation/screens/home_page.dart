import 'package:flutter/material.dart';
import 'package:pekedex_app/api/pokedex_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexServices().getPokemonList(),
      initialData: const [],
      builder: (context, snapshot) {
        List<dynamic> pokemons = snapshot.data['results'];
        return ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(pokemons[index]['name']),
            );
          },
        );
      },
    );
  }
}
