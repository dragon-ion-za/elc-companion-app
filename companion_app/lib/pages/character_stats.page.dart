import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterStatsPage extends ConsumerWidget {
  const CharacterStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lookup = ref.watch(lookupCacheProvider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Column(children: [
          CircleAvatar(
            radius: 64,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Bio'),
            maxLines: 3,
          ),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Race'),
              value: null,
              items: lookup.value!.races
                  .map((e) => DropdownMenuItem(child: Text(e.name), value: e.id,))
                  .toList(),
              onChanged: (item) {}),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Faction'),
              value: null,
              items: lookup.value!.factions
                  .map((e) => DropdownMenuItem(child: Text(e.name), value: e.id))
                  .toList(),
              onChanged: (item) {}),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Era'),
              value: null,
              items: lookup.value!.eras
                  .map((e) => DropdownMenuItem(child: Text(e.name), value: e.id))
                  .toList(),
              onChanged: (item) {}),
        ]),
      ),
    );
  }
}
