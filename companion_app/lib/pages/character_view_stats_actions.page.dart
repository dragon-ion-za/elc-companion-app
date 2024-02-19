import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/painter/hitpoint.painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewStatsActionsPage extends ConsumerStatefulWidget {
  const CharacterViewStatsActionsPage(this._model, {super.key});

  final PlayableCharacter _model;

  @override
  ConsumerState<CharacterViewStatsActionsPage> createState() =>
      _CharacterViewStatsActionsPageState();
}

class _CharacterViewStatsActionsPageState
    extends ConsumerState<CharacterViewStatsActionsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Hitpoints: '),
                SizedBox(
                  width: 128,
                  height: 8,
                  child: CustomPaint(
                    painter: HitpointPainter(
                        context,
                        widget._model.survivability.maxHp,
                        widget._model.survivability.currentHp),
                  ),
                ),
                Text(
                    'Mitigation: ${widget._model.survivability?.mitigationScore ?? 0}')
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Actions: '),
            for (var action in widget._model.actions)
              ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  child: Text(action.cost.toString()),
                ),
                title: Text(action.name),
                subtitle: Text(action.damage > 0
                    ? 'Acc: +${action.accuracy} | Dmg: ${action.damage}'
                    : action.blurb),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(action.description)),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info)),
              )
          ],
        ),
      ),
    );
  }
}
