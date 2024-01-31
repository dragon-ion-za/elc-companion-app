import 'package:elc_companion_app/models/continuum-skill-node.dart';
import 'package:elc_companion_app/painter/continuum.painter.dart';
import 'package:flutter/material.dart';

class CharacterSkillsPage extends StatefulWidget {
  const CharacterSkillsPage({super.key});

  @override
  State<CharacterSkillsPage> createState() => _CharacterSkillsPageState();
}

class _CharacterSkillsPageState extends State<CharacterSkillsPage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });
      },
      child: CustomPaint(
          painter: ContinuumPainter(context, _offset, [ ContinuumSkillNode('Combat Training', Offset(200, 200), 0)]),
        ),
    );
  }
}
