import 'package:elc_companion_app/models/skill_training.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/widgets/skill_manager_modal.dart';
import 'package:elc_companion_app/widgets/skill_training_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterSkillsPage extends ConsumerStatefulWidget {
  const CharacterSkillsPage({super.key});

  @override
  ConsumerState<CharacterSkillsPage> createState() =>
      _CharacterSkillsPageState();
}

class _CharacterSkillsPageState extends ConsumerState<CharacterSkillsPage> {
  void updateSkillTraining(
      context, CharacterNotifier charNotifier, String skillId, num progression, List<String> abilityIds) async {
    final result = await showModalBottomSheet<SkillTraining>(
        context: context, builder: (context) => SkillManagerModal(skillId, progression, abilityIds));
    if (result != null) {
      charNotifier.updateSkillProgression(
          skillId, result.trainingProgress, result.abilityIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.read(lookupCacheProvider).value!.skills;
    final updateNotifier = ref.read(characterProvider.notifier);
    final character = ref.watch(characterProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 256,
              child: ListView.builder(
                  itemCount: character!.skills.length,
                  itemBuilder: (ctx, index) => ListTile(
                        title: Text(skills
                            .firstWhere(
                                (x) => x.id == character!.skills[index].id)
                            .name),
                        trailing: SkillTrainingIndicator(
                            character!.skills[index].progression),
                        onTap: () => updateSkillTraining(context,
                            updateNotifier, character!.skills[index].id, character!.skills[index].progression, character!.skills[index].abilityIds),
                      )),
            ),
          ),
          Center(
            child: Text('Fully Trained Skills: ${updateNotifier.getFullyTrainedSkillCount()}/3'),
          ),
          const Center(
            child: Text('OR'),
          ),
          Center(
            child: Text('Fully Trained Skills: ${updateNotifier.getFullyTrainedSkillCount()}/2 and Partially Trained Skills: ${updateNotifier.getPratiallyTrainedSkillCount()}/2'),
          )
        ],
      ),
    );
  }
}
