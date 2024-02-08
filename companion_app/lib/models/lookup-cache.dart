import 'package:elc_companion_app/models/ability.dart';
import 'package:elc_companion_app/models/item.dart';
import 'package:elc_companion_app/models/lookup.dart';

class LookupCache {
  final List<Lookup> races;
  final List<Lookup> factions;
  final List<Lookup> eras;
  final List<Lookup> talentsFlaws;
  final List<Item> items;
  final List<Lookup> skills;
  final List<Ability> abilities;

  LookupCache(this.races, this.factions, this.eras, this.talentsFlaws, this.items, this.skills, this.abilities);
}