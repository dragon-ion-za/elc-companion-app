import 'package:elc_companion_app/providers/character-list.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/screens/character_modification.screen.dart';
import 'package:elc_companion_app/screens/character_view.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterListScreen extends ConsumerWidget {
  const CharacterListScreen({super.key});

  navigateToAddPage(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const CharacterModificationScreen()));
  }

  navigateToViewPage(context, String characterId) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => CharacterViewScreen(characterId)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterListProvider);
    final lookupCache = ref.watch(lookupCacheProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          IconButton(
              onPressed: () {
                navigateToAddPage(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                opacity: 0.5,
                fit: BoxFit.cover)),
        child: () {
          if (characters.isLoading || lookupCache.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (characters.hasError || lookupCache.hasError) {
            return const Text('Oops..');
          } else if (characters.hasValue) {
            final value = characters.value;
            return value == null || value.isEmpty
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You have no characters yet'),
                          IconButton.filled(
                            onPressed: () {
                              navigateToAddPage(context);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: value.length,
                    separatorBuilder: (ctx, index) => const SizedBox(
                      height: 4,
                    ),
                    itemBuilder: (ctx, index) => Material(
                      child: ListTile(
                        onTap: () { navigateToViewPage(context, value[index].id!); },
                        title: Text(value[index].name),
                        subtitle: Text('${lookupCache.value!.factions.firstWhere((x) => x.id == value[index].factionId).name} | ${lookupCache.value!.eras.firstWhere((x) => x.id == value[index].eraId).name}'),
                        leading: CircleAvatar(
                          child: Text(
                              '${value[index].name.split(' ').first[0]}${value[index].name.split(' ').last[0]}'),
                        ),
                      ),
                    ),
                  );
          }
        }(),
      ),
    );
  }
}
