import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Module 5 Assignment',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 70,
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: const Icon(Icons.add_business_rounded),
        title: const Text("Home"),
        actions: const [
          Icon(Icons.search),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "This is mod 5 Assignment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: const TextSpan(
                text: "My ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
                children: [
                  TextSpan(
                    text: "phone ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: "name ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  TextSpan(
                    text: "Your phone name",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
