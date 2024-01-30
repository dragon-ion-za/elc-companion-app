import 'package:elc_companion_app/pages/character_stats.page.dart';
import 'package:flutter/material.dart';

class CharacterModificationScreen extends StatelessWidget {
  const CharacterModificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modify Character'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  opacity: 0.5,
                  fit: BoxFit.cover)),
          child: TabBarView(children: [
            CharacterStatsPage()
          ],),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Badge(
              child: Tab(
                icon: Icon(Icons.account_circle),
              ),
            )
          ],
        ),
      ),
    );
  }
}
