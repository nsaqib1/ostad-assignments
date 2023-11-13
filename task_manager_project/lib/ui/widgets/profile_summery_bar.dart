import 'package:flutter/material.dart';

import '../screens/edit_profile_screen.dart';

class ProfileSummeryBar extends StatelessWidget {
  const ProfileSummeryBar({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: enableOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            }
          : null,
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: const Text(
        "Abu Najmus Saqib",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: const Text(
        "saqib.dev@gmail.com",
        style: TextStyle(color: Colors.white),
      ),
      tileColor: Colors.green,
    );
  }
}
