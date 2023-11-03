import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module11_assignment/models/photo_model.dart';
import 'package:module11_assignment/widgets/photo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PhotoModel> photos = [];
  String? error;
  bool inProgress = false;

  Future<void> getPhotos() async {
    inProgress = true;
    setState(() {});
    try {
      final response = await get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos"),
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        for (final Map<String, dynamic> photo in decodedJson) {
          photos.add(PhotoModel.fromJson(photo));
        }
      } else {
        error = "API request Failed! Error Code: ${response.statusCode}";
      }
    } catch (e) {
      error = "Could not make API call!";
    }

    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    getPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery App"),
      ),
      body: inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error != null
              ? Center(
                  child: Text(error!),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: photos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return PhotoItem(photo: photos[index]);
                  },
                ),
    );
  }
}
