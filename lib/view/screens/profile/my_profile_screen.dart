import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'My Profile Screen',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
