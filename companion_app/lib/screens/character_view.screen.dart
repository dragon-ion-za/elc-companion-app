import 'package:elc_companion_app/pages/character_equipment.page.dart';
import 'package:elc_companion_app/pages/character_skills.page.dart';
import 'package:elc_companion_app/pages/character_stats.page.dart';
import 'package:elc_companion_app/pages/character_talents.page.dart';
import 'package:elc_companion_app/pages/character_view_stats_actions.page.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewScreen extends ConsumerStatefulWidget {
  const CharacterViewScreen(this._characterId, {super.key});

  final String _characterId;

  @override
  ConsumerState<CharacterViewScreen> createState() =>
      _CharacterViewScreenState();
}

class _CharacterViewScreenState extends ConsumerState<CharacterViewScreen> {
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
    final charNotifier = ref.read(characterProvider.notifier);
    final lookupCache = ref.watch(lookupCacheProvider);

    return FutureBuilder(
        future: charNotifier.loadById(widget._characterId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: ListTile(
                    title: Text(snapshot.data!.value!.name),
                    subtitle: Text(
                        '${lookupCache.value!.races.firstWhere((x) => x.id == snapshot.data!.value!.raceId).name} | ${lookupCache.value!.factions.firstWhere((x) => x.id == snapshot.data!.value!.factionId).name} | ${lookupCache.value!.eras.firstWhere((x) => x.id == snapshot.data!.value!.eraId).name}'),
                    trailing: CircleAvatar(
                          child: Text(
                              '${snapshot.data!.value!.name.split(' ').first[0]}${snapshot.data!.value!.name.split(' ').last[0]}'),
                        ),
                  ),
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
                      CharacterViewStatsActionsPage(),
                      CharacterTalentsPage(),
                      CharacterEquipmentPage(),
                      CharacterSkillsPage()
                    ],
                  ),
                ),
                bottomNavigationBar: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.account_circle),
                    ),
                    Tab(
                      icon: Icon(Icons.star),
                    ),
                    Tab(
                      icon: Icon(Icons.shield),
                    ),
                    Tab(
                      icon: Icon(Icons.account_tree),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Oops!!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
