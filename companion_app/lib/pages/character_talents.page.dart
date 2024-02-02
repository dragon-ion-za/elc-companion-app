import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterTalentsPage extends ConsumerWidget {
  const CharacterTalentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talentsFlaws = ref.watch(lookupCacheProvider).value!.talentsFlaws;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            child: ListView.builder(itemCount: talentsFlaws.length, itemBuilder: (ctx, index) => ListTile(
                  title: Text(talentsFlaws[index].name),
                  subtitle: Text(talentsFlaws[index].blurb ?? ''),
                  trailing: Switch(value: false, onChanged: (value) {}),
                )),
          ),
          Text('Points remaining')
        ],
      ),
    );
  }
}
