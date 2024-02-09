import 'package:elc_companion_app/pages/character_equipment.page.dart';
import 'package:elc_companion_app/pages/character_skills.page.dart';
import 'package:elc_companion_app/pages/character_stats.page.dart';
import 'package:elc_companion_app/pages/character_talents.page.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterModificationScreen extends ConsumerStatefulWidget {
  const CharacterModificationScreen({super.key});

  @override
  ConsumerState<CharacterModificationScreen> createState() =>
      _CharacterModificationScreenState();
}

class _CharacterModificationScreenState
    extends ConsumerState<CharacterModificationScreen> {
  void submitCharacter(CharacterNotifier charNotifier) async {
    List<String> errors = [];

    if (!charNotifier.areStatsValid()) {
      errors.add('Stats are invalid.');
    }

    if (!charNotifier.areSkillsValid()) {
      errors.add('Skill selection is invalid.');
    }

    if (!charNotifier.isEquipmentValid()) {
      errors.add('Equipment selection is invalid.');
    }

    if (!charNotifier.areTalentsValid()) {
      errors.add('Talent selection is invalid.');
    }

    if (errors.isEmpty) {
      try {
        await charNotifier.save();

        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('The following tabs are invalid:'),
                  for (var error in errors) Text(error)
                ]),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final char = ref.watch(characterProvider);
    final charNotifier = ref.read(characterProvider.notifier);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modify Character'),
          actions: [
            IconButton(
                onPressed: () {
                  submitCharacter(charNotifier);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  opacity: 0.5,
                  fit: BoxFit.cover)),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CharacterStatsPage(),
              CharacterTalentsPage(),
              CharacterEquipmentPage(),
              CharacterSkillsPage()
            ],
          ),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Badge(
              key: UniqueKey(),
              isLabelVisible: !char!.areStatsValid,
              child: Tab(
                icon: Icon(Icons.account_circle),
              ),
            ),
            Badge(
              isLabelVisible: !charNotifier.areTalentsValid(),
              child: Tab(
                icon: Icon(Icons.star),
              ),
            ),
            Badge(
              isLabelVisible: !charNotifier.isEquipmentValid(),
              child: Tab(
                icon: Icon(Icons.shield),
              ),
            ),
            Badge(
              isLabelVisible: !charNotifier.areSkillsValid(),
              child: Tab(
                icon: Icon(Icons.account_tree),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
