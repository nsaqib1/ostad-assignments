import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/main_bottom_nav_screen.dart';
import '../widgets/body_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();

    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return isLoggedIn
                ? const MainBottomNavScreen()
                : const LoginScreen();
          },
        ),
        (route) {
          return false;
        },
      ),
    );
  }

  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset("assets/images/logo.svg"),
        ),
      ),
    );
  }
}
