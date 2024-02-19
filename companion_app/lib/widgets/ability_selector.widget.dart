import 'package:elc_companion_app/models/ability.dart';
import 'package:flutter/material.dart';

class AbilitySelector extends StatefulWidget {
  const AbilitySelector(
      this._abilityIndex, this._abilities, this._abilityId, this._onChange,
      {super.key});

  final num _abilityIndex;
  final List<Ability> _abilities;
  final String _abilityId;
  final Function(String? item) _onChange;

  @override
  State<AbilitySelector> createState() => _AbilitySelectorState();
}

class _AbilitySelectorState extends State<AbilitySelector> {
  @override
  Widget build(BuildContext context) {

    var ordinalTitle = 'First';

    if (widget._abilityIndex == 1) {
      ordinalTitle = 'Second';
    } else if (widget._abilityIndex == 2) {
      ordinalTitle = 'Third';
    } else if (widget._abilityIndex == 3) {
      ordinalTitle = 'Elite';
    }

    return Row(
      children: [
        SizedBox(width: 128, child: Text('$ordinalTitle Ability')),
        Expanded(
          child: DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Ability'),
            items: widget._abilities
                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                .toList(),
            value: widget._abilityId.isNotEmpty ? widget._abilityId : null,
            validator: (value) =>
                value == null ? 'Ability selection is required.' : null,
            onChanged: widget._onChange,
          ),
        )
      ],
    );
  }
}
