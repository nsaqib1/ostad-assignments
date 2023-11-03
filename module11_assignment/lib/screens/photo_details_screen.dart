import 'package:flutter/material.dart';
import 'package:module11_assignment/models/photo_model.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final PhotoModel photo;
  const PhotoDetailsScreen({super.key, required this.photo});

  @override
  State<PhotoDetailsScreen> createState() => _PhotoDetailsScreenState();
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                photo.url,
                errorBuilder: (context, error, stackTrace) {
                  return const AspectRatio(
                    aspectRatio: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Icon(
                        Icons.image,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Title: ${photo.title}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "ID: ${photo.id}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
