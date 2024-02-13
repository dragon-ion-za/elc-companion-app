import 'package:elc_companion_app/models/lookup.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewStatsActionsPage extends ConsumerStatefulWidget {
  CharacterViewStatsActionsPage({super.key});

  @override
  ConsumerState<CharacterViewStatsActionsPage> createState() =>
      _CharacterViewStatsActionsPageState();
}

class _CharacterViewStatsActionsPageState
    extends ConsumerState<CharacterViewStatsActionsPage> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lookup = ref.watch(lookupCacheProvider);
    final character = ref.read(characterProvider);

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Form(
          key: form,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Hitpoints: '),
                SizedBox(
                  width: 128,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (character!.survivability != null)
                        for (var i = 1;
                            i <= character!.survivability!.maxHp;
                            i++)
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: Container(
                              color: i < character!.survivability!.currentHp
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                    ],
                  ),
                ),
                Text('Mitigation: ${character!.survivability?.mitigationScore ?? 0}')
              ],
            ),
            Text('Actions: ')
          ],),
        ),
      ),
    );
  }
}
