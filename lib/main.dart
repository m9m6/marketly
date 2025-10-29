import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
     Marketly());
}

class Marketly extends StatelessWidget {
  const Marketly({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
