import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onRetryPressed;
  final String? message;
  const CustomErrorWidget({
    super.key,
    this.message,
    this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message ?? "Unknown Error"),
          SizedBox.fromSize(size: Size.fromHeight(16)),
          if(onRetryPressed != null)
          ElevatedButton(onPressed: onRetryPressed, child: Text("Retry")),
        ],
      ),
    );
  }
}
