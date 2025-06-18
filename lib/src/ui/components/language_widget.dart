import 'dart:math';

import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final double? dotSize;
  final String? language;
  const LanguageWidget({super.key, this.dotSize = 32, required this.language});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    Color generateRandomColor() {
      return HSVColor.fromAHSV(
        1.0,
        random.nextDouble() * 360,
        0.7 + random.nextDouble() * 0.3,
        0.8 + random.nextDouble() * 0.2,
      ).toColor();
    }

    return Row(
      spacing: 4,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: generateRandomColor(),
          ),
        ),
        Text(language ?? "", style: TextStyle(color: Colors.black54, fontSize: 14)),
      ],
    );
  }
}
