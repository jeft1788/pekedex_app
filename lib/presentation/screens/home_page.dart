import 'package:flutter/material.dart';
import 'package:pekedex_app/api/pokedex_service.dart';
import 'package:pekedex_app/models/pokemon_llist_response_model.dart';
import 'package:pekedex_app/presentation/screens/pokemon_details_page.dart';
import 'package:pekedex_app/widgets/pokemon_card.dart';
import 'package:string_capitalize/string_capitalize.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexServices().getPokemonList(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }  
        List<Pokemon> pokemons = snapshot.data;
          return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
        
          itemCount: pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> PokemonDetailsPage( 
                    name: pokemons[index].name!,
                  ),
                ),
              );
            },
            child: PokemonCard(pokemons[index]),
            );
          },
        );
      },
    );
  }}
