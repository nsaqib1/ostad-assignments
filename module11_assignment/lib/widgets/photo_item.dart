import 'package:flutter/material.dart';
import 'package:module11_assignment/models/photo_model.dart';
import 'package:module11_assignment/screens/photo_details_screen.dart';

class PhotoItem extends StatelessWidget {
  final PhotoModel photo;
  const PhotoItem({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoDetailsScreen(photo: photo),
          ),
        );
      },
      child: Row(
        children: [
          Image.network(
            photo.thumbnailUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 80,
                height: 80,
                child: Icon(
                  Icons.image,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              photo.title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
