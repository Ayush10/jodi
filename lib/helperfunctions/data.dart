import 'dart:math' as math;

import 'package:flutter/material.dart';

List<String> _names = [
  'Lana',
  'Lina',
  'Luna',
  'Rina',
  'Rena',
  'Runa',
];

class User {
  static int _nameIndex = 0;

  String name;
  int age;
  ImageProvider image;

  User({this.image, this.name, this.age}) {
    name = name ?? _names[(_nameIndex++) % _names.length];
    age = age ?? 21 + math.Random().nextInt(10);
  }
}
