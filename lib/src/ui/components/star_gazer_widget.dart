import 'package:flutter/material.dart';

class StarGazerWidget extends StatelessWidget {
  final int starCount;
  const StarGazerWidget({super.key, required this.starCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(Icons.star_border_rounded, size: 22, color: Colors.black54),
        Text(
          "$starCount",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}
