import 'package:elc_companion_app/models/lookup.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterStatsPage extends ConsumerStatefulWidget {
  CharacterStatsPage({super.key});

  @override
  ConsumerState<CharacterStatsPage> createState() => _CharacterStatsPageState();
}

class _CharacterStatsPageState extends ConsumerState<CharacterStatsPage> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lookup = ref.watch(lookupCacheProvider);
    final updateNotifier = ref.read(characterProvider.notifier);
    final character = ref.read(characterProvider);
    final nameArray = character!.name.split(' ');
    final firstName = nameArray.first.isNotEmpty ? nameArray.first[0].toUpperCase() : '';
    final lastName = nameArray.last.isNotEmpty ? nameArray.last[0].toUpperCase() : '';

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Form(
          key: form,
          child: Column(children: [
            CircleAvatar(
              radius: 64,
              child: Text(nameArray.isNotEmpty ? '$firstName$lastName' : ''),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name *'),
              onChanged: (value) {
                updateNotifier.updateCharacterStats(name: value);
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Name is required' : null,
              initialValue: character!.name,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Bio'),
              onChanged: (value) {
                updateNotifier.updateCharacterStats(bio: value);
              },
              validator: (value) => null,
              maxLines: 3,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Race *'),
              value: character!.raceId,
              items: lookup.value!.races
                  .map((e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.id,
                      ))
                  .toList(),
              onChanged: (item) {
                updateNotifier.updateCharacterStats(raceId: item);
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Race is required' : null,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Faction *'),
              value: character!.factionId,
              items: lookup.value!.factions
                  .map(
                      (e) => DropdownMenuItem(child: Text(e.name), value: e.id))
                  .toList(),
              onChanged: (item) {
                updateNotifier.updateCharacterStats(factionId: item);
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Faction is required' : null,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Era *'),
              value: character!.eraId,
              items: lookup.value!.eras
                  .map(
                      (e) => DropdownMenuItem(child: Text(e.name), value: e.id))
                  .toList(),
              onChanged: (item) {
                updateNotifier.updateCharacterStats(eraId: item);
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Era is required' : null,
            ),
          ]),
        ),
      ),
    );
  }
}
