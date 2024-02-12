import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/widgets/container_slot.widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterEquipmentPage extends ConsumerWidget {
  const CharacterEquipmentPage({super.key});

  void onEquipmentSelect(
      String? item, String containerId, String slotId, WidgetRef ref) {
    final charNotifier = ref.read(characterProvider.notifier);

    charNotifier.updateEquipment(item!, containerId, slotId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charNotifier = ref.watch(characterProvider.notifier);

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Column(
                    children: [
                      const Text('On Self'),
                      ContainerSlot('Main Weapon', 'root', 'main',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Sling Weapon', 'root', 'sling',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Sidearm', 'root', 'sidearm',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Tactical Melee', 'root', 'knife',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Head', 'root', 'head',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Chest', 'root', 'chest',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Rig', 'root', 'rig',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                      ContainerSlot('Belt', 'root', 'belt',
                          (item, containerId, slotId) {
                        onEquipmentSelect(item, containerId, slotId, ref);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Text(
                  'Points remaining: ${charNotifier.getRequisitionPoints()}'))
        ],
      ),
    );
  }
}
