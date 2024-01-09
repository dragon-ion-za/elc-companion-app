import 'package:flutter/material.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ELC'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            opacity: 0.5,
            fit: BoxFit.cover
          )
        ),
        child: Column(children: [Text('Under Construction')],)),
    );
  }

}