import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/models/skill_training.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/providers/playable_character.provider.dart';
import 'package:elc_companion_app/widgets/skill_manager_modal.dart';
import 'package:elc_companion_app/widgets/skill_training_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewSkillsPage extends ConsumerStatefulWidget {
  const CharacterViewSkillsPage(this._model, {super.key});

  final PlayableCharacter _model;

  @override
  ConsumerState<CharacterViewSkillsPage> createState() =>
      _CharacterViewSkillsPageState();
}

class _CharacterViewSkillsPageState
    extends ConsumerState<CharacterViewSkillsPage> {
  @override
  Widget build(BuildContext context) {
    final skills = ref.read(lookupCacheProvider).value!.skills;
    final updateNotifier =
        ref.read(playableCharacterProvider(widget._model.id!).notifier);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 256,
              child: ListView.builder(
                  itemCount: widget._model.skills.length,
                  itemBuilder: (ctx, index) => ListTile(
                        leading: SkillTrainingIndicator(
                            widget._model.skills[index].progression),
                        title: Badge(
                          isLabelVisible: (widget._model.skills[index].progression / 8).floor() > (widget._model.skills[index].abilityIds.where((x) => x.isNotEmpty).length),
                          child: Text(skills
                              .firstWhere(
                                  (x) => x.id == widget._model.skills[index].id)
                              .name),
                        ),
                        trailing: IconButton(
                            onPressed:
                                widget._model.skills[index].progression < 40
                                    ? () {
                                        updateNotifier.incrementSkillProgress(
                                            widget._model.skills[index].id);
                                      }
                                    : null,
                            icon: Icon(Icons.add_circle)),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
