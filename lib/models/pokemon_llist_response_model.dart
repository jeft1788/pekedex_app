

class PokemonListResponse{
  int? count;
  String? next;
  int? previous;
  List<Pokemon>? results;

  PokemonListResponse({this.count, this.next, this.previous, this.results});
  PokemonListResponse.fromJson(Map<String, dynamic> json){
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Pokemon>[];
      json['results'].forEach((v) {
        results!.add(Pokemon.fromJson(v));
      });
    }
  }
}

class Pokemon {
   String? name;
  String? url;
  String? image;

  Pokemon({this.name, this.url, this.image});

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}