import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerSlot extends ConsumerStatefulWidget {
  const ContainerSlot(this.slotName, this.containerId, this.slotId, this.onChanged, {super.key});

  final String slotName;
  final String containerId;
  final String slotId;
  final void Function(String? item, String containerId, String slotId) onChanged;

  @override
  ConsumerState<ContainerSlot> createState() => _ContainerSlotState();
}

class _ContainerSlotState extends ConsumerState<ContainerSlot> {

  @override
  Widget build(BuildContext context) {

    final lookup = ref.read(lookupCacheProvider);

    return Row(
      children: [
        SizedBox(width: 128, child: Text(widget.slotName)),
        Expanded(
            child: DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Equipment'),
                items: lookup.value!.items
                  .where((x) => x.containers.any((y) => y.id == widget.containerId && y.slot.contains(widget.slotId)))
                  .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name))).toList(),
                onChanged: (item) { widget.onChanged(item, widget.containerId, widget.slotId); }))
      ],
    );
  }
}
