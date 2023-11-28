import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pekedex_app/models/pokemon_llist_response_model.dart';

class PokedexServices {
  final _dio = Dio();
  String url = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=0';
  Future<dynamic> getPokemonList() async {
    try{
    final Response response= await _dio.get(url);
    final PokemonListResponse pokemonListResponse =
      PokemonListResponse.fromJson(response.data);
      final List<Pokemon> pokemonList = pokemonListResponse.results!;
      return pokemonList;   
    }catch(e){
      print(e);
    }
  }
}
