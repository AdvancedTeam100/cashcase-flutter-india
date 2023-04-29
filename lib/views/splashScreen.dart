import 'package:cashfuse/utils/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Images.logo,
                fit: BoxFit.contain,
                scale: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
