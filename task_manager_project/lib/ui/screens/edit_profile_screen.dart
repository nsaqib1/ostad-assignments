import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';
import '../widgets/body_background.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/snackbar_builder.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.user?.email ?? "";
    _firstNameController.text = AuthController.user?.firstName ?? "";
    _lastNameController.text = AuthController.user?.lastName ?? "";
    _mobileController.text = AuthController.user?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          const ProfileSummeryBar(enableOnTap: false),
          Expanded(
            child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        photoPickerField(),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          validator: _emailValidator,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            hintText: "First Name",
                          ),
                          validator: (String? value) {
                            return _commonValidator(
                              value,
                              "First Name is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            hintText: "Last Name",
                          ),
                          validator: (String? value) {
                            return _commonValidator(
                              value,
                              "Last Name is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _mobileController,
                          decoration: const InputDecoration(
                            hintText: "Mobile",
                          ),
                          validator: (String? value) {
                            return _commonValidator(
                              value,
                              "Mobile is Required!",
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password (Optional)",
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _updateProfileInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: updateProfile,
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate() == false) return;

    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "email": _emailController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      inputData['password'] = _passwordController.text;
    }

    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
          email: _emailController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobile: _mobileController.text.trim(),
          photo: photoInBase64 ?? AuthController.user?.photo));
      if (mounted) {
        showSnackMessage(context, 'Update profile success!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed. Try again.');
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

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: const Text('Select a photo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
