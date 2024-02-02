import 'package:elc_companion_app/models/lookup.dart';

class LookupItem extends Lookup {
  bool isSelected = false;

  LookupItem(super.id, super.name, super.blurb, super.score);
}
