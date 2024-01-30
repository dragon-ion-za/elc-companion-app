import 'package:flutter/material.dart';

class CharacterTalentsPage extends StatelessWidget {
  const CharacterTalentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Marksman'),
                  subtitle: Text('Adds +1 to Accurecy Bonus'),
                  trailing: Switch(value: false, onChanged: (value) {}),
                )
              ],
            ),
          ),
          Text('Points remaining')
        ],
      ),
    );
  }
}
