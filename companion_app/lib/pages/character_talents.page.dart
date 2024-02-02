import 'package:elc_companion_app/models/lookup-item.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterTalentsPage extends ConsumerStatefulWidget {
  const CharacterTalentsPage(this.onValidate, {super.key});

  final Function(bool isValid) onValidate;

  @override
  ConsumerState<CharacterTalentsPage> createState() => _CharacterTalentsPageState();
}

class _CharacterTalentsPageState extends ConsumerState<CharacterTalentsPage> {
  List<LookupItem> _talentsFlaws = [];
  num _currentTalentPoints = 2; // TODO: Read from rules engine

  @override
  void initState() {
    super.initState();
    _talentsFlaws = ref.read(lookupCacheProvider).value!.talentsFlaws.map((e) => LookupItem(e.id, e.name, e.blurb, e.score)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            child: ListView.builder(itemCount: _talentsFlaws.length, itemBuilder: (ctx, index) => ListTile(
                  title: Text(_talentsFlaws[index].name),
                  subtitle: Text(_talentsFlaws[index].blurb ?? ''),
                  trailing: Switch(value: _talentsFlaws[index].isSelected, onChanged: (value) {
                    setState(() {
                      _currentTalentPoints += _talentsFlaws[index].score * (value ? -1 : 1);
                      _talentsFlaws[index].isSelected = value;
                    });

                    widget.onValidate(_currentTalentPoints <= 0);
                  }),
                )),
          ),
          Text('Points remaining: $_currentTalentPoints')
        ],
      ),
    );
  }
}
