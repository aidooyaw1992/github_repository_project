import 'package:flutter/material.dart';

class ForkCountWidget extends StatelessWidget {
  final int forkCount;
  const ForkCountWidget({super.key, required this.forkCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Image.asset(
          "assets/images/fork.png",
          height: 14,
          color: Colors.black54,
        ),
        Text(
          "$forkCount",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}
