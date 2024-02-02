import 'package:elc_companion_app/pages/character_equipment.page.dart';
import 'package:elc_companion_app/pages/character_skills.page.dart';
import 'package:elc_companion_app/pages/character_stats.page.dart';
import 'package:elc_companion_app/pages/character_talents.page.dart';
import 'package:flutter/material.dart';

class CharacterModificationScreen extends StatefulWidget {
  const CharacterModificationScreen({super.key});

  @override
  State<CharacterModificationScreen> createState() => _CharacterModificationScreenState();
}

class _CharacterModificationScreenState extends State<CharacterModificationScreen> {
  bool _isStatsPageValid = false;
  bool _isTalentsPageValid = false;
  bool _isEquipmentPageValid = false;
  bool _isSkillsPageBalid = false;

  @override
  Widget build(BuildContext context) {
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
            CharacterStatsPage((bool isValid) {
              setState(() {
                _isStatsPageValid = isValid;
              });
            }),
            CharacterTalentsPage(),
            CharacterEquipmentPage(),
            CharacterSkillsPage()
          ],),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Badge(
              isLabelVisible: !_isStatsPageValid,  
              child: Tab(
                icon: Icon(Icons.account_circle),
              ),
            ),
            Badge(
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
