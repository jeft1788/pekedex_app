import 'package:flutter/material.dart';
import 'package:pekedex_app/api/pokedex_service.dart';
import 'package:pekedex_app/models/pokemon_llist_response_model.dart';
import 'package:string_capitalize/string_capitalize.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexServices().getPokemonList(),
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }  
        List<Pokemon> pokemons = snapshot.data;
        return ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(              
               pokemons[index].name!.capitalize()                             
              ), 
            );
          },
        );
      },
    );
  }}
