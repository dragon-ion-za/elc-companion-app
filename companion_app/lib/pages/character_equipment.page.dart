import 'package:flutter/material.dart';

class CharacterEquipmentPage extends StatelessWidget {
  const CharacterEquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: ListView(
          children: [
            Column(
              children: [
                Text('On Self'),
                Row(
                  children: [
                    Text('Left Arm'),
                    Expanded(child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Equipment'),
                        items: [DropdownMenuItem(child: Text('Pistol'))],
                        onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    Text('Head'),
                    Expanded(child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Equipment'),
                        items: [DropdownMenuItem(child: Text('NVG'))],
                        onChanged: (item) {}))
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text('On Belt'),
                Row(
                  children: [
                    Text('Slot 1'),
                    Expanded(child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Equipment'),
                        items: [DropdownMenuItem(child: Text('Grenade'))],
                        onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    Text('Slot 2'),
                    Expanded(child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Equipment'),
                        items: [DropdownMenuItem(child: Text('Health Stim'))],
                        onChanged: (item) {}))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
