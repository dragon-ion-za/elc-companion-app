import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/painter/hitpoint.painter.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewStatsActionsPage extends ConsumerStatefulWidget {
  CharacterViewStatsActionsPage(this._model, {super.key});

  final PlayableCharacter _model;

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
                  height: 8,
                  child: CustomPaint(
                    painter: HitpointPainter(context, widget._model.survivability.maxHp, widget._model.survivability.currentHp),
                  ),
                ),
                Text('Mitigation: ${widget._model.survivability?.mitigationScore ?? 0}')
              ],
            ),
            Text('Actions: ')
          ],),
        ),
      ),
    );
  }
}
