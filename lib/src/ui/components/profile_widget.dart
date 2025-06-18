import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String avatarUrl;
  final String? username;
  final double? customSize;
  const ProfileWidget({super.key, required this.avatarUrl, this.username,  this.customSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              width: customSize?? 32,
              height: customSize?? 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    avatarUrl ?? 'https://picsum.photos/200/200?random=4',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
         if(username != null )...{
          Text(username!,  style: TextStyle(color: Colors.black54, fontSize: 12),)
         }
        ],
      ),
    );
  }
}
