import 'package:elc_companion_app/models/equipment.dart';
import 'package:elc_companion_app/models/item.dart';
import 'package:elc_companion_app/models/playable_character.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:elc_companion_app/widgets/container_slot.widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterViewEquipmentPage extends ConsumerStatefulWidget {
  const CharacterViewEquipmentPage(this._model, {super.key});

  final PlayableCharacter _model;

  @override
  ConsumerState<CharacterViewEquipmentPage> createState() =>
      _CharacterViewEquipmentPageState();
}

class _CharacterViewEquipmentPageState
    extends ConsumerState<CharacterViewEquipmentPage> {

  String getItemName(String containerId, String slotId, List<Equipment> equipment, List<Item> items) {
    var itemId = equipment.firstWhere((x) => x.slotId == slotId && x.containerId == containerId, orElse: () => Equipment('', '', '')).itemId;
    return itemId.isNotEmpty ? items.firstWhere((x) => x.id == itemId).name : 'Empty';
  }

  @override
  Widget build(BuildContext context) {
    final lookup = ref.watch(lookupCacheProvider);
    final equipmentIds = widget._model.equipment.map((x) => x.itemId).toList();
    final items = lookup.value!.items.where((x) => equipmentIds.contains(x.id)).toList();
    final containers = items
        .where((x) => x.attributes.any((y) => y.type == 'container'))
        .toList();

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('On Self'),
            ContainerSlot.readOnly('Main Weapon', 'root', 'main', getItemName('root', 'main', widget._model.equipment, items)),
            ContainerSlot.readOnly('Sling Weapon', 'root', 'sling', getItemName('root', 'sling', widget._model.equipment, items)),
            ContainerSlot.readOnly('Sidearm', 'root', 'sidearm', getItemName('root', 'sidearm', widget._model.equipment, items)),
            ContainerSlot.readOnly('Tactical Melee', 'root', 'knife', getItemName('root', 'knife', widget._model.equipment, items)),
            ContainerSlot.readOnly('Head', 'root', 'head', getItemName('root', 'head', widget._model.equipment, items)),
            ContainerSlot.readOnly('Chest', 'root', 'chest', getItemName('root', 'chest', widget._model.equipment, items)),
            ContainerSlot.readOnly('Rig', 'root', 'rig', getItemName('root', 'rig', widget._model.equipment, items)),
            ContainerSlot.readOnly('Belt', 'root', 'belt', getItemName('root', 'belt', widget._model.equipment, items)),

            for (var container in containers)
            ...[
              Text('In ${container.name}'),
              for (var slot in container.attributes.where((x) => x.type == 'container').toList())
                ContainerSlot.readOnly(slot.slot!, container.name, slot.slot!, getItemName(container.name, slot.slot!, widget._model.equipment, items))
            ]
          ],
        ),
      ),
    );
  }
}
