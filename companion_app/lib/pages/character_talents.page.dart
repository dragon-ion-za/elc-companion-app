import 'package:elc_companion_app/models/lookup-item.dart';
import 'package:elc_companion_app/providers/character.provider.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterTalentsPage extends ConsumerStatefulWidget {
  const CharacterTalentsPage(this.onValidate, {super.key});

  final Function(bool isValid) onValidate;

  @override
  ConsumerState<CharacterTalentsPage> createState() =>
      _CharacterTalentsPageState();
}

class _CharacterTalentsPageState extends ConsumerState<CharacterTalentsPage> {
  List<LookupItem> _talentsFlaws = [];

  @override
  void initState() {
    super.initState();
    _talentsFlaws = ref
        .read(lookupCacheProvider)
        .value!
        .talentsFlaws
        .map((e) => LookupItem(e.id, e.name, e.blurb, e.score))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final charNotifier = ref.watch(characterProvider.notifier);
    final char = ref.watch(characterProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 256,
              child: ListView.builder(
                  itemCount: _talentsFlaws.length,
                  itemBuilder: (ctx, index) => ListTile(
                        title: Text(_talentsFlaws[index].name),
                        subtitle: Text(_talentsFlaws[index].blurb ?? ''),
                        trailing: Switch(
                            value: char!.talentIds
                                .any((x) => x == _talentsFlaws[index].id),
                            onChanged: (value) {
                              charNotifier.toggleTalent(
                                  _talentsFlaws[index].id, value);
                            }),
                      )),
            ),
          ),
          Center(child: Text('Points remaining: ${charNotifier.getTalentPoints()}'))
        ],
      ),
    );
  }
}
