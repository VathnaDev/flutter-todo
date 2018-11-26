import 'package:flutter/material.dart';

class Misc {
  static MaterialColor getColorPriority(int priorityNumber) {
    switch (priorityNumber) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.cyan;
      case 3:
        return Colors.blue;
    }
    return null;
  }
}
