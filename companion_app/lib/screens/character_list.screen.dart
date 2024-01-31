import 'package:elc_companion_app/models/character.dart';
import 'package:elc_companion_app/providers/character-list.provider.dart';
import 'package:elc_companion_app/screens/character_modification.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterListScreen extends ConsumerWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                opacity: 0.5,
                fit: BoxFit.cover)),
        child: switch (characters) {
          AsyncLoading() => const CircularProgressIndicator(),
          AsyncError() => const Center(
              child: Text('Oops..'),
            ),
          AsyncValue<List<Character>>(:final value) =>
            value == null || value.isEmpty
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You have no characters yet'),
                          IconButton.filled(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CharacterModificationScreen()));
                          }, icon: const Icon(Icons.add),),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (ctx, index) => ListTile(
                      title: Text(value[index].id),
                    ),
                  ),
        },
      ),
    );
  }
}
