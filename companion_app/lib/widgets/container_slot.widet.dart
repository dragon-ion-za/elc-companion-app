import 'package:elc_companion_app/helpers/constants.dart';
import 'package:elc_companion_app/models/item.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class ContainerSlot extends ConsumerStatefulWidget {
  const ContainerSlot(
      this.slotName, this.containerId, this.slotId, this.onChanged,
      {super.key}) : isReadOnly = false, itemId = null;

  const ContainerSlot.readOnly(this.slotName, this.containerId, this.slotId, this.itemId) : isReadOnly = true, onChanged = null;

  final String slotName;
  final String containerId;
  final String slotId;
  final String? itemId;

  final void Function(String? item, String containerId, String slotId)?
      onChanged;

  final bool isReadOnly;

  @override
  ConsumerState<ContainerSlot> createState() => _ContainerSlotState();
}

class _ContainerSlotState extends ConsumerState<ContainerSlot> {
  @override
  Widget build(BuildContext context) {
    final lookup = ref.read(lookupCacheProvider);

    return Row(
      children: [
        SizedBox(width: 128, height: 32, child: Text(widget.slotName)),
        if (widget.isReadOnly)
          SizedBox(height: 32, child: Text(widget.itemId == null ? '' : lookup.value!.items.firstWhereOrNull((Item x) => x.id == widget.itemId)?.name ?? ''))
        else
          Expanded(
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Equipment'),
                  items: lookup.value!.items
                      .where((x) => x.attributes.any((y) => y.type == ATTRIBUTE_TYPES_SLOT) && x.tags.any((y) => y == widget.slotId))
                      .map((e) =>
                          DropdownMenuItem(value: e.id, child: Text(e.name)))
                      .toList(),
                  onChanged: (item) {
                    widget.onChanged!(item, widget.containerId, widget.slotId);
                  }))
      ],
    );
  }
}
