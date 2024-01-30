import 'package:flutter/material.dart';

class CharacterStatsPage extends StatelessWidget {
  const CharacterStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Column(children: [
          CircleAvatar(
            radius: 64,
          ),
          TextField(decoration: InputDecoration(labelText: 'Name'),),
          TextField(decoration: InputDecoration(labelText: 'Bio'), maxLines: 3,),
          DropdownButtonFormField(decoration: InputDecoration(labelText: 'Race'), items: [DropdownMenuItem(child: Text('Earthling'))], onChanged: (item) {}),
          DropdownButtonFormField(decoration: InputDecoration(labelText: 'Faction'),items: [DropdownMenuItem(child: Text('S.I.Er.A.'))], onChanged: (item) {}),
          DropdownButtonFormField(decoration: InputDecoration(labelText: 'Era'),items: [DropdownMenuItem(child: Text('Past'))], onChanged: (item) {}),
        ]),
      ),
    );
  }
}
