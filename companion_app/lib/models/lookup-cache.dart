import 'package:elc_companion_app/models/lookup.dart';

class LookupCache {
  final List<Lookup> races;
  final List<Lookup> factions;
  final List<Lookup> eras;
  final List<Lookup> talentsFlaws;
  final List<Lookup> skills;

  LookupCache(this.races, this.factions, this.eras, this.talentsFlaws, this.skills);
}