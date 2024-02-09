import 'package:elc_companion_app/models/skill_training.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillManagerModal extends ConsumerStatefulWidget {
  const SkillManagerModal(this.skillId, this.progression, this.abilityIds,
      {super.key});

  final String skillId;
  final num progression;
  final List<String> abilityIds;

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
      _trainingLevel = { '2' };
    } else if (_training.trainingProgress > 0) {
      _trainingLevel = { '1' };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lookup = ref.read(lookupCacheProvider).value!;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: form,
        child: Column(
          children: [
            SegmentedButton(
              segments: const [
                ButtonSegment(value: '0', label: Text('Untrained')),
                ButtonSegment(value: '1', label: Text('Partially Trained')),
                ButtonSegment(value: '2', label: Text('Trained'))
              ],
              selected: _trainingLevel,
              onSelectionChanged: (selection) => setState(() {
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
              Row(
                children: [
                  const SizedBox(width: 128, child: Text('First Ability')),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'Ability'),
                      items: lookup.abilities
                          .where((x) => x.skillId == widget.skillId)
                          .map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.name)))
                          .toList(),
                      value: _training.abilityIds[0].isNotEmpty ? _training.abilityIds[0] : null,
                      validator: (value) => value == null
                          ? 'Ability selection is required.'
                          : null,
                      onChanged: (item) {
                        setState(() {
                          _training.abilityIds[0] = item!;
                        });
                      },
                    ),
                  )
                ],
              ),
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
