import 'package:flutter/material.dart';
import 'widget_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Module 8 Assignment',
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);

    if (orientation == Orientation.portrait) {
      // Build Portrait Mode UI
      return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                buildProfilePicture(),
                const SizedBox(height: 10),
                Center(child: buildName(context)),
                const SizedBox(height: 15),
                buildDescription(context),
                const SizedBox(height: 10),
                buildImageGrid(),
              ],
            ),
          ),
        ),
      );
    } else {
      // Build Landscape Mode UI
      return Scaffold(
        appBar: buildAppBar(),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: buildProfilePicture(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    buildName(context),
                    const SizedBox(height: 15),
                    buildDescription(context),
                    const SizedBox(height: 10),
                    buildImageGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
