import 'package:elc_companion_app/models/character.dart';
import 'package:flutter/material.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  bool _isLoading = false;
  List<Character> _characters = [];

  @override
  Widget build(BuildContext context) {

    Widget content = const CircularProgressIndicator();

    if (!_isLoading) {
      content = ListView.builder(itemCount: _characters.length, itemBuilder: (ctx, index) => ListTile(
        title: Text(_characters[index].id),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ELC'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                opacity: 0.5,
                fit: BoxFit.cover)),
        child: Center(
          child: content
        ),
      ),
    );
  }
}
