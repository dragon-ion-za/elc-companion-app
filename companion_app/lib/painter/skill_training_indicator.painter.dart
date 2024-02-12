import 'dart:math';
import 'package:flutter/material.dart';

class SkillTrainingIndicatorPainter extends CustomPainter {
  const SkillTrainingIndicatorPainter(this.context, this._progression);
  final BuildContext context;
  final num _progression;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.clipRect(backgroundRect);

    Paint untrainedPaint = Paint()..color = Colors.purple[100]!;
    Paint trainedPainter = Paint()..color = Colors.green;
    Paint experiencedPainter = Paint()..color = Colors.purple[400]!;
    Paint masteredPainter = Paint()..color = Colors.purple[600]!;
    Paint elitePainter = Paint()..color = Colors.purple[900]!;

    canvas.save();

    final masteryLevel = (_progression / 8).floor();
    final currentLevelProgress = _progression - (masteryLevel * 8);

    final label = TextSpan(text: masteryLevel == 4 ? '3' : masteryLevel > 1 ? '2' : masteryLevel.toString() , style: TextStyle(color: Colors.white));
      final textPainter = TextPainter(text: label, textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset((textPainter.width / 2) + (24 - textPainter.width), (textPainter.height / 2) + (24 - textPainter.height)));

    for (var i = 0; i < 8; i ++) {
      var painter = untrainedPaint;

      if (masteryLevel == 4) {
        painter = elitePainter;
      } else if (i + 1 <= currentLevelProgress) {
        painter = trainedPainter;
      } else if (masteryLevel > 1) {
        painter = masteredPainter;
      } else if (masteryLevel == 1) {
        painter = experiencedPainter;
      }

      final rads = (i * 45) * (pi/180);
      final x = 20 * cos(rads) + 24;
      final y = 20 * sin(rads) + 24;
      canvas.drawCircle(Offset(x, y), 4, painter);
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}