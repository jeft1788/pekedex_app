import 'package:custom_image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pekedex_app/api/pokedex_service.dart';
import 'package:string_capitalize/string_capitalize.dart';

import '../../models/pokemon_details_model.dart';



class PokemonDetailsPage extends StatelessWidget {
  final String name;
  const PokemonDetailsPage({
    super.key,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PokedexServices().getPokemonDetails(name),
      initialData: const {},
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        PokemonDetails pokemonDetails = snapshot.data;
        return Scaffold(
            appBar: AppBar(
              title: Text(
                pokemonDetails.name!.capitalize(),
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            backgroundColor: pokemonDetails.bgColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(
                        pokemonDetails.sprites!.other!.home!.frontDefault!),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                pokemonDetails.name!.capitalize(),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              height: 2.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Id: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${pokemonDetails.id}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Type: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ...pokemonDetails.types!
                                    .map((e) => Text(
                                          '${e.type!.name!.capitalize()} ',
                                        ))
                                    .toList()
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Height: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${pokemonDetails.height}dm'),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                const Text(
                                  'Weight: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${pokemonDetails.weight}hg'),
                              ],
                            ),
                            Row(children: [
                              const Text(
                                'Base experience: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(pokemonDetails.baseExperience.toString()),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              'Stats',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              height: 2.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 3),
                              children: [
                                ...pokemonDetails.stats!
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.stat!.name!.capitalize(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  thumbColor:
                                                      Colors.transparent,
                                                  inactiveTrackColor:
                                                      Colors.grey,
                                                  activeTrackColor:
                                                      pokemonDetails.bgColor!,
                                                  thumbShape:
                                                      const RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              0.0),
                                                ),
                                                child: Slider(
                                                  value: e.baseStat!.toDouble(),
                                                  max: 100,
                                                  min: 0,
                                                  onChanged: (_) {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              'Moves: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              height: 2.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 200.0,
                              width: double.infinity,
                              child: ListView(
                                children: [
                                  ...pokemonDetails.moves!
                                      .map((e) => ListTile(
                                            title: Text(
                                              e.move!.name!.capitalize(),
                                            ),
                                            subtitle: Text(
                                              'Learned at level ${e.versionGroupDetails![0].levelLearnedAt.toString()}',
                                            ),
                                          ))
                                      .toList()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}