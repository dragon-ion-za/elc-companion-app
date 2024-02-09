import 'package:elc_companion_app/painter/skill_training_indicator.painter.dart';
import 'package:flutter/material.dart';

class SkillTrainingIndicator extends StatelessWidget {
  const SkillTrainingIndicator(this.progression, {super.key});

  final num progression;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 48,
      height: 48,
      child: CustomPaint(
        painter: SkillTrainingIndicatorPainter(context, progression)
      ),
    );
  }

}