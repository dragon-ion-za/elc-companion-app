import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewTalentsHumanityPage extends ConsumerStatefulWidget {
  const CharacterViewTalentsHumanityPage(this._model, {super.key});

  final PlayableCharacter _model;

  @override
  ConsumerState<CharacterViewTalentsHumanityPage> createState() =>
      _CharacterViewTalentsHumanityPageState();
}

class _CharacterViewTalentsHumanityPageState
    extends ConsumerState<CharacterViewTalentsHumanityPage> {
  @override
  Widget build(BuildContext context) {
    final lookup = ref.watch(lookupCacheProvider);
    final talentsFlaws = lookup.value!.talentsFlaws
        .where((x) => widget._model.talentIds.contains(x.id));

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('Talents and Flaws: '),
            for (var talentFlaw in talentsFlaws)
              ListTile(
                title: Text(talentFlaw.name),
                subtitle: Text(talentFlaw.blurb ?? ''),
              ),
          ],
        ),
      ),
    );
  }
}
