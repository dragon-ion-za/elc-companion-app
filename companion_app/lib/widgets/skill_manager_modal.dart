import 'package:elc_companion_app/models/skill_training.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/widgets/ability_selector.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillManagerModal extends ConsumerStatefulWidget {
  const SkillManagerModal(this.skillId, this.progression, this.abilityIds,
      {super.key})
      : readOnlyProgression = false;

  const SkillManagerModal.abilities(
      this.skillId, this.progression, this.abilityIds,
      {super.key})
      : readOnlyProgression = true;

  final String skillId;
  final num progression;
  final List<String> abilityIds;
  final bool readOnlyProgression;

  @override
  ConsumerState<SkillManagerModal> createState() => _SkillManagerModalState();
}

class _SkillManagerModalState extends ConsumerState<SkillManagerModal> {
  final form = GlobalKey<FormState>();
  final SkillTraining _training = SkillTraining();
  Set<String> _trainingLevel = {'0'};

  void saveData(context) {
    if (form.currentState!.validate()) {
      Navigator.pop(context, _training);
    }
  }

  @override
  void initState() {
    super.initState();

    _training.trainingProgress = widget.progression;
    _training.abilityIds = widget.abilityIds;

    if (_training.trainingProgress >= 8) {
      _trainingLevel = {'2'};
    } else if (_training.trainingProgress > 0) {
      _trainingLevel = {'1'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final lookup = ref.read(lookupCacheProvider).value!;

    var masteryLevel = 'Untrained';

    if (_training.trainingProgress == 40) {
      masteryLevel = 'Elite';
    } else if (_training.trainingProgress >= 32) {
      masteryLevel = 'Mastered';
    } else if (_training.trainingProgress >= 16) {
      masteryLevel = 'Experienced';
    } else if (_training.trainingProgress >= 8) {
      masteryLevel = 'Proficient';
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: form,
        child: Column(
          children: [
            if (widget.readOnlyProgression)
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Skill Mastery: ')),
                    Text(masteryLevel),
                  ],
                ),
              )
            else
              SegmentedButton(
                segments: const [
                  ButtonSegment(value: '0', label: Text('Untrained')),
                  ButtonSegment(value: '1', label: Text('Partially Trained')),
                  ButtonSegment(value: '2', label: Text('Proficient'))
                ],
                selected: _trainingLevel,
                onSelectionChanged: widget.readOnlyProgression
                    ? null
                    : (Set<String> selection) => setState(() {
                          _trainingLevel = selection;
                          switch (_trainingLevel.first) {
                            case '0':
                              _training.trainingProgress = 0;
                              _training.abilityIds[0] = '';
                            case '1':
                              _training.trainingProgress = 4;
                              _training.abilityIds[0] = '';
                            case '2':
                              _training.trainingProgress = 8;
                          }
                        }),
              ),
            if (_training.trainingProgress >= 8)
              for (var i = 0; i < (_training.trainingProgress / 8).floor(); i++)
              if (i < 4)
                AbilitySelector(
                    i,
                    lookup.abilities
                        .where((x) => x.skillId == widget.skillId)
                        .toList(),
                    _training.abilityIds[i], (item) {
                  _training.abilityIds[i] = item!;
                }),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                const SizedBox(
                  width: 16,
                ),
                OutlinedButton(
                    onPressed: () {
                      saveData(context);
                    },
                    child: Text('Save'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
