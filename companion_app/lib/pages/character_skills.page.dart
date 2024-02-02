import 'dart:math';

import 'package:elc_companion_app/models/continuum-skill-node.dart';
import 'package:elc_companion_app/models/lookup.dart';
import 'package:elc_companion_app/painter/continuum.painter.dart';
import 'package:elc_companion_app/providers/lookup-cache.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterSkillsPage extends ConsumerStatefulWidget {
  const CharacterSkillsPage({super.key});

  @override
  ConsumerState<CharacterSkillsPage> createState() =>
      _CharacterSkillsPageState();
}

class _CharacterSkillsPageState extends ConsumerState<CharacterSkillsPage> {
  Offset _offset = Offset.zero;
  double _zoom = 1.0;
  final _zoomFactor = 1.0;
  final spiralOrigin = const Offset(200, 200);
  final spiralAngleRadians = 90 * (pi / 180);

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(lookupCacheProvider).value!.skills;

    return GestureDetector(
      onScaleUpdate: (details) {
        setState(() {
          _offset += details.focalPointDelta;
          _zoom = _zoomFactor * details.scale;
          debugPrint('$_zoom');
        });
      },
      child: CustomPaint(
        painter: ContinuumPainter(
          context,
          _offset,
          _zoom,
          [
            for (var i = 0; i < skills.length; i++) _buildNode(i, skills[i]),
          ],
        ),
      ),
    );
  }

  ContinuumSkillNode _buildNode(num index, Lookup skill) {
    final angle = spiralAngleRadians * index;
    final originX = (spiralOrigin.dx * angle) *
        cos(angle);
    final originY = (spiralOrigin.dy * angle) *
        sin(angle);
    return ContinuumSkillNode(skill.name, Offset(originX, originY), 0);
  }
}
