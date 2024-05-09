import 'package:elc_companion_app/helpers/constants.dart';
import 'package:elc_companion_app/models/equipment.dart';
import 'package:elc_companion_app/models/item.dart';
import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/widgets/container_slot.widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class CharacterViewEquipmentPage extends ConsumerStatefulWidget {
  const CharacterViewEquipmentPage(this._model, {super.key});

  final PlayableCharacter _model;

  @override
  ConsumerState<CharacterViewEquipmentPage> createState() =>
      _CharacterViewEquipmentPageState();
}

class _CharacterViewEquipmentPageState
    extends ConsumerState<CharacterViewEquipmentPage> {

  String? getItemId(String containerId, String slotId, List<Equipment> equipment) {
    return equipment.firstWhereOrNull((x) => x.containerId == containerId && x.slotId == slotId)?.itemId;
  }

  @override
  Widget build(BuildContext context) {
    final lookup = ref.read(lookupCacheProvider);
    final containersIds = widget._model.equipment.map((x) => x.containerId).toSet().toList();
    final containers = widget._model.equipment.where((x) => containersIds.any((y) => x.id == y)).toList();

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('On Self'),
            ContainerSlot.readOnly('Main Weapon', CONTAINER_ROOT, SlotTypes.main, getItemId(CONTAINER_ROOT, SlotTypes.main, widget._model.equipment)),
            ContainerSlot.readOnly('Sling Weapon', CONTAINER_ROOT, SlotTypes.sling, getItemId(CONTAINER_ROOT, SlotTypes.sling, widget._model.equipment)),
            ContainerSlot.readOnly('Sidearm', CONTAINER_ROOT, SlotTypes.sidearm, getItemId(CONTAINER_ROOT, SlotTypes.sidearm, widget._model.equipment)),
            ContainerSlot.readOnly('Tactical Melee', CONTAINER_ROOT, SlotTypes.knife, getItemId(CONTAINER_ROOT, SlotTypes.knife, widget._model.equipment)),
            ContainerSlot.readOnly('Head', CONTAINER_ROOT, SlotTypes.head, getItemId(CONTAINER_ROOT, SlotTypes.head, widget._model.equipment)),
            ContainerSlot.readOnly('Chest', CONTAINER_ROOT, SlotTypes.chest, getItemId(CONTAINER_ROOT, SlotTypes.chest, widget._model.equipment)),
            ContainerSlot.readOnly('Rig', CONTAINER_ROOT, SlotTypes.rig, getItemId(CONTAINER_ROOT, SlotTypes.rig, widget._model.equipment)),
            ContainerSlot.readOnly('Belt', CONTAINER_ROOT, SlotTypes.belt, getItemId(CONTAINER_ROOT, SlotTypes.belt, widget._model.equipment)),

            for (var container in containers)
            ...[
              Text('In ${lookup.value!.items.firstWhereOrNull((Item x) => x.id == container.itemId)?.name ?? ''}'),
              for (var slot in widget._model.equipment.where((x) => x.containerId == container.id))
                ContainerSlot.readOnly(slot.slot!, container.id, slot.slot!, getItemName(container.name, slot.slot!, widget._model.equipment, items))
            ]
          ],
        ),
      ),
    );
  }
}
