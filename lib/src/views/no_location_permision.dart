import 'package:flutter/material.dart';

class NoLocation extends StatelessWidget {
  const NoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please turn on your device location or check location permissions')
            ],
          ),
        ),
      ),
    );
  }


}