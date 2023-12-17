import 'package:firebase_project/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FirebaseApp extends StatelessWidget {
  const FirebaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Project',
      home: const HomeScreen(),
    );
  }
}
