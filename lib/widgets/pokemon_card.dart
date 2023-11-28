import 'package:custom_image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:pekedex_app/models/pokemon_llist_response_model.dart';
import 'package:string_capitalize/string_capitalize.dart';

class PokemonCard extends StatelessWidget{
  final Pokemon pokemon; 
  const PokemonCard(this.pokemon, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(
                   pokemon.name!.capitalize()  
              ),
            ),
          ),
          CustomImage(pokemon.image!)
          //CustomImage(image: pokemon.image!),
        ],
      ),
    );
  }

}