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
  ConsumerState<CharacterModificationScreen> createState() => _CharacterModificationScreenState();
}

class _CharacterModificationScreenState extends ConsumerState<CharacterModificationScreen> {
  bool _isStatsPageValid = false;
  bool _isTalentsPageValid = false;
  bool _isEquipmentPageValid = false;
  bool _isSkillsPageBalid = false;

  @override
  Widget build(BuildContext context) {
    final char = ref.watch(characterProvider);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modify Character'),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  opacity: 0.5,
                  fit: BoxFit.cover)),
          child: TabBarView(physics: const NeverScrollableScrollPhysics(),
            children: [
            CharacterStatsPage(),
            CharacterTalentsPage((bool isValid) {
              setState(() {
                _isTalentsPageValid = isValid;
              });
            }),
            CharacterEquipmentPage(),
            CharacterSkillsPage()
          ],),
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
              isLabelVisible: !_isTalentsPageValid, 
              child: Tab(
                icon: Icon(Icons.star),
              ),
            ),
            Badge(
              child: Tab(
                icon: Icon(Icons.shield),
              ),
            ),
            Badge(
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
