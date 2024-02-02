import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterStatsPage extends ConsumerStatefulWidget {
  CharacterStatsPage(this.onValidate, {super.key});
  
  final Function(bool isValid) onValidate;

  @override
  ConsumerState<CharacterStatsPage> createState() => _CharacterStatsPageState();
}

class _CharacterStatsPageState extends ConsumerState<CharacterStatsPage> {
  final form = GlobalKey<FormState>();
  _validateForm() {
    widget.onValidate(form.currentState!.validate());
  }

  @override
  Widget build(BuildContext context) {
    final lookup = ref.watch(lookupCacheProvider);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Form(
          key: form,
          child: Column(children: [
            CircleAvatar(
              radius: 64,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                _validateForm();
              },
              validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Bio'),
              onChanged: (value) {
                _validateForm();
              },
              validator: (value) => null,
              maxLines: 3,
            ),
            DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Race'),
                value: null,
                items: lookup.value!.races
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e.id,
                        ))
                    .toList(),
                onChanged: (item) {},
              validator: (value) => value == null || value.isEmpty ? 'Race is required' : null,),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Faction'),
                value: null,
                items: lookup.value!.factions
                    .map((e) =>
                        DropdownMenuItem(child: Text(e.name), value: e.id))
                    .toList(),
                onChanged: (item) {},
              validator: (value) => value == null || value.isEmpty ? 'Faction is required' : null,),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Era'),
                value: null,
                items: lookup.value!.eras
                    .map((e) =>
                        DropdownMenuItem(child: Text(e.name), value: e.id))
                    .toList(),
                onChanged: (item) {},
              validator: (value) => value == null || value.isEmpty ? 'Era is required' : null,),
          ]),
        ),
      ),
    );
  }
}
