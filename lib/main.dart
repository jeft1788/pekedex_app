import 'package:flutter/material.dart';
import 'package:pekedex_app/presentation/screens/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
        ),
        body: const HomePage(),
      ),
    );
  }
}
