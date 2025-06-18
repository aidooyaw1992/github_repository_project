import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onRetryPressed;
  final String? message;
  const CustomErrorWidget({super.key, this.message, this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red[900], size: 80),
          Text(
            "Ooops! Something went wrong!",
            style: TextStyle(fontSize: 24, color: Colors.red[900]),
          ),
          SizedBox.fromSize(size: Size.fromHeight(4)),
          Text(message ?? "Unknown Error"),
          SizedBox.fromSize(size: Size.fromHeight(16)),
          if (onRetryPressed != null)
            ElevatedButton(
              onPressed: onRetryPressed, 

              child: Text("Retry",style:  TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 42),
                backgroundColor: Colors.red[900]
              ),),
        ],
      ),
    );
  }
}
