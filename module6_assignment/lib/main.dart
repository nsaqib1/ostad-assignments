import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Module 6 Assignment',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> images = const [
    {
      "image":
          "https://cdn.pixabay.com/photo/2016/12/04/21/58/rabbit-1882699_1280.jpg",
      "title": ""
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2014/06/21/08/43/rabbit-373691_1280.jpg",
      "title": ""
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2016/11/21/16/59/animal-1846462_1280.jpg",
      "title": ""
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2020/05/19/12/04/natural-5190433_1280.jpg",
      "title": ""
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2017/07/31/21/38/white-2561331_1280.jpg",
      "title": ""
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2019/07/31/19/21/animal-4375952_1280.jpg",
      "title": ""
    },
  ];

  mySnackBar(BuildContext context, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  myListTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              images[index]["image"]!,
            ),
          ),
        ),
      ),
      title: Text("Photo $index"),
      subtitle: Text("Description for photo $index"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Photo Gallery"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Text(
            "Welcome to My Photo Gallery!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              isDense: true,
              hintText: "Search for Photos...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .85,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: images.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => mySnackBar(context, "Rabbit $index Tapped!"),
                child: Column(
                  children: [
                    Image.network(
                      images[index]["image"]!,
                      fit: BoxFit.cover,
                      height: 90,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Rabit $index",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          myListTile(0),
          myListTile(1),
          myListTile(2),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mySnackBar(context, "Photos Uploaded Successfully!"),
        child: const Icon(Icons.upload),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
