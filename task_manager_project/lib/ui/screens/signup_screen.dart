import 'package:flutter/material.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';
import '../widgets/body_background.dart';
import '../widgets/snackbar_builder.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

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
                      'Join With Us',
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
                      validator: _emailValidator,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (value) {
                        return _commonValidator(value, "Enter First Name");
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (value) {
                        return _commonValidator(value, "Enter Last Name");
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (value) {
                        return _commonValidator(value, "Enter Mobile Number");
                      },
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
                        return _commonValidator(value, "Enter Password");
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _signUp,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
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

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
        "mobile": _mobileController.text.trim(),
      });
      _signUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(context, 'Account has been created! Please login.');
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, 'Account creation failed! Please try again.', true);
        }
      }
    }
  }

  String? _emailValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter Your Email";
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final isValid = RegExp(
      pattern,
    ).hasMatch(value!);

    if (isValid == false) {
      return "Enter Your Valid Email";
    }

    return null;
  }

  String? _commonValidator(String? value, String errorMsg) {
    if (value?.trim().isEmpty ?? true) {
      return errorMsg;
    }
    return null;
  }

  void _clearTextFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
