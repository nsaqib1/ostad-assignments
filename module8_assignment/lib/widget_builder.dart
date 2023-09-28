import 'package:flutter/material.dart';

const String kName = "Najmus Sakib";
const String kDescription =
    "Deserunt duis ipsum ex ut qui non. Ex culpa minim proident veniam do velit Lorem. Sit aute magna exercitation deserunt.";

AppBar buildAppBar() {
  return AppBar(
    title: const Text("Profile"),
    toolbarHeight: 50,
  );
}

GridView buildImageGrid() {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: 9,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
    ),
    itemBuilder: (context, index) => Image.asset(
      "images/image2.jpg",
      fit: BoxFit.cover,
    ),
  );
}

AspectRatio buildProfilePicture() {
  return AspectRatio(
    aspectRatio: 1,
    child: Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image1.jpg"),
        ),
      ),
    ),
  );
}

Text buildName(BuildContext context) {
  return Text(
    kName,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

Text buildDescription(BuildContext context) {
  return Text(
    kDescription,
    style: Theme.of(context).textTheme.bodyLarge,
  );
}
