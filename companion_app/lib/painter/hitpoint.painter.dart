import 'package:flutter/material.dart';

class HitpointPainter extends CustomPainter {
  const HitpointPainter(this.context, this._maxHp, this._currentHp);
  final BuildContext context;
  final num _maxHp;
  final num _currentHp;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.clipRect(backgroundRect);

    Paint maxHpPainter = Paint()..color = Theme.of(context).colorScheme.secondary;
    Paint hpPainter = Paint()..color = Theme.of(context).colorScheme.tertiary;

    canvas.save();

    for (var i = 0; i < _maxHp; i ++) {
      canvas.drawRect(Rect.fromLTRB((16.0 * i), 0, (16.0 * i) + 8, 8), i + 1 <= _currentHp ? hpPainter : maxHpPainter);
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}