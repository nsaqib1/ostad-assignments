import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/login_screen.dart';

import '../screens/edit_profile_screen.dart';

class ProfileSummeryBar extends StatefulWidget {
  const ProfileSummeryBar({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummeryBar> createState() => _ProfileSummeryBarState();
}

class _ProfileSummeryBarState extends State<ProfileSummeryBar> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.enableOnTap
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
      title: Text(
        fullname,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(color: Colors.white),
      ),
      tileColor: Colors.green,
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  String get fullname {
    final user = AuthController.user;
    return "${user?.firstName ?? ""} ${user?.lastName ?? ""}";
  }

  String get email {
    return AuthController.user?.email ?? "";
  }
}
