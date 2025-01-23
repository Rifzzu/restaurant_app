import 'package:flutter/material.dart';

enum RestaurantColors {
  green("Green", Color(0xFFEEEDEB));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
