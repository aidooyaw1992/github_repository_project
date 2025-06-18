import 'package:flutter/material.dart';

class RepoStatus extends StatelessWidget {
  final bool isPrivate;
  const RepoStatus({super.key, this.isPrivate = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            isPrivate
                ? "assets/images/repo_private.png"
                : "assets/images/repo_public.png",
            color: Colors.black54,
            width: 16,
            height: 16,
          ),
          Text(
            isPrivate ? "private" : "public",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
