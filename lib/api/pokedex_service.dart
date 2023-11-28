
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:pekedex_app/models/pokemon_llist_response_model.dart';

import '../models/pokemon_details_model.dart';

class PokedexServices {
  final _dio = Dio();
  String url = 'https://pokeapi.co/api/v2';
  //String url = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=0';
  Future<List<Pokemon>?> getPokemonList() async {
    try{
    final Response response= await _dio.get('$url/pokemon?limit=50&offset=0');
    final PokemonListResponse pokemonListResponse =
      PokemonListResponse.fromJson(response.data);
    final List<Pokemon> pokemonList = pokemonListResponse.results!;
    return await parseResponse(pokemonList);
    }catch(e){
      rethrow;
    }
  }
Future<List<Pokemon>> parseResponse(List<Pokemon> pokemons) async {
    List<Pokemon> parsedPokemons = [];
    for (Pokemon pokemon in pokemons) {
      final String pokemonImage = await getPokemonImage(pokemon.url!);
      pokemon.image = pokemonImage;
      // pokemon.bgColor = bgColor;
      parsedPokemons.add(pokemon);
    }
    return parsedPokemons;
  }
  Future<String> getPokemonImage(String url)async{
    try {
      final Response response = await _dio.get(url);
      final PokemonDetails pokemonDetails =
          PokemonDetails.fromJson(response.data);
      final String pokemonImage =
          pokemonDetails.sprites!.other!.home!.frontDefault!;
      return pokemonImage;
    } catch (e) {
         rethrow;
    }
  }

  
  Future<PokemonDetails> getPokemonDetails(String name) async {
    try {
      final Response response = await _dio.get('$url/pokemon/$name');
      final PokemonDetails pokemonDetails =
          PokemonDetails.fromJson(response.data);

      final Color bgColor = await getImagePalette(NetworkImage(
          pokemonDetails.sprites!.other!.officialArtwork!.frontDefault!));
      pokemonDetails.bgColor = bgColor;
      return pokemonDetails;
    } catch (e) {
      rethrow;
    }
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}

