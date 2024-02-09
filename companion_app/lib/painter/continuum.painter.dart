import 'dart:math';

import 'package:elc_companion_app/models/continuum-skill-node.dart';
import 'package:flutter/material.dart';

class ContinuumPainter extends CustomPainter {
  const ContinuumPainter(this.context, this.offset, this.zoom, this.skills, {
    this.isAntiAlias = true,
  });
  final BuildContext context;
  final bool isAntiAlias;
  final List<ContinuumSkillNode> skills;
  final Offset offset;
  final double zoom;

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Theme.of(context).colorScheme.secondaryContainer;
    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(backgroundRect, background);
    canvas.clipRect(backgroundRect);
    
    canvas.save();
    Paint drawingPaint = Paint()..color = Theme.of(context).colorScheme.tertiary;
    for (final skill in skills) {
      final currentPosition = (skill.position + offset) * zoom;

      // Draw Continuum node with label
      canvas.drawCircle(currentPosition, 64 * zoom, drawingPaint);
      final label = TextSpan(text: skill.name, style: TextStyle(color: Colors.white));
      final textPainter = TextPainter(text: label, textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(currentPosition.dx - (textPainter.width / 2), currentPosition.dy - (textPainter.height / 2)));

      // Draw Progress
      Paint progressionPaint = Paint()..color = Theme.of(context).colorScheme.error;
      drawNodeProgressionPips(canvas, 76, currentPosition, progressionPaint);

      // Draw ability node
      for (var i = 33; i < 360; i += 90) {
        final rads = i * (pi/180);
        final x = ((skill.position.dx / 2) + 64) * cos(rads) + currentPosition.dx;
        final y = ((skill.position.dy / 2) + 64) * sin(rads) + currentPosition.dy;
        drawAbilityNode(canvas, drawingPaint, Offset(x, y));
      }
    }
    
    canvas.restore();
  }

  void drawAbilityNode(Canvas canvas, Paint paint, Offset position) {
    canvas.drawCircle(position, 32, paint);

    drawNodeProgressionPips(canvas, 42, position, paint);
  }

  void drawNodeProgressionPips(Canvas canvas, double radius, Offset currentPosition, Paint paint) {
    for (var i = 0; i < 360; i += 45) {
      final rads = i * (pi/180);
      final x = radius * cos(rads) + currentPosition.dx;
      final y = radius * sin(rads) + currentPosition.dy;
      canvas.drawCircle(Offset(x, y), 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}