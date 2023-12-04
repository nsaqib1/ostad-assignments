import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/user_model.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/utils/form_validators.dart';
import 'package:task_manager_project/ui/widgets/snackbar_builder.dart';

import '../widgets/body_background.dart';
import 'forgot_password_screen.dart';
import 'main_bottom_nav_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Get Started with',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: FormValidators.validateEmail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        return FormValidators.validateEmptyField(
                          value,
                          "Enter Password",
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final response = await NetworkCaller().postRequest(
      Urls.login,
      body: {
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      },
      isLogin: true,
    );

    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      AuthController.saveUserInformation(
        response.jsonResponse["token"],
        UserModel.fromJson(
          response.jsonResponse["data"],
        ),
      );

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
          (route) => false,
        );
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, "Please Check Email/Password");
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Login Failed! Try Again");
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
