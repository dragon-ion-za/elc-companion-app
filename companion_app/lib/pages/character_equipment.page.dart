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
          padding: const EdgeInsets.all(8),
          children: [
            Column(
              children: [
                Text('On Self'),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Main Weapon')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Sling Weapon')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Sidearm')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Tactical Melee')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Head')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Chest')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Rig')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('Pistol'))],
                            onChanged: (item) {}))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 128, child: Text('Belt')),
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Equipment'),
                            items: [DropdownMenuItem(child: Text('NVG'))],
                            onChanged: (item) {}))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
