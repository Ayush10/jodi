import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

extension MatrixExtension on Matrix4 {
  Matrix4 rotateDegrees(double angleDegrees, {Offset origin}) {
    var angleRadians = degreeToRadians(angleDegrees);

    if (origin == null || (origin.dx == 0.0 && origin.dy == 0)) {
      return this..rotateZ(angleRadians);
    }
    return this
      ..translate(origin.dx, origin.dy)
      ..multiply(Matrix4.rotationZ(angleRadians))
      ..translate(-origin.dx, -origin.dy);
  }

  Matrix4 scaleWithOrigin(double x, {double y, Offset origin}) {
    x ??= 1;
    y ??= x;

    if (x == 1 && y == 1) {
      return this;
    }

    if (origin == null || (origin.dx == 0.0 && origin.dy == 0)) {
      return this..multiply(Matrix4.identity()..scale(x, y));
    }

    return this
      ..translate(origin.dx, origin.dy)
      ..multiply(Matrix4.identity()..scale(x, y))
      ..translate(-origin.dx, -origin.dy);
  }
}

double degreeToRadians(double angleDegree) {
  return angleDegree * (math.pi / 100.0);
}
