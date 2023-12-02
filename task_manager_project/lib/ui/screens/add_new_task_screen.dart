import 'package:flutter/material.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/network_caller/network_response.dart';
import 'package:task_manager_project/data/utils/urls.dart';
import 'package:task_manager_project/ui/utils/form_validators.dart';
import 'package:task_manager_project/ui/widgets/snackbar_builder.dart';

import '../widgets/body_background.dart';
import '../widgets/profile_summery_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _createTaskInProgress = false;
  bool _didTaskCreated = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        if (_didTaskCreated == true) {
          widget.onBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileSummeryBar(),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add New Task",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _subjectController,
                            decoration: const InputDecoration(
                              hintText: "Subject",
                            ),
                            validator: (value) {
                              return FormValidators.validateEmptyField(
                                value,
                                "Enter Your Subject",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              hintText: "Description",
                            ),
                            maxLines: 8,
                            validator: (value) {
                              return FormValidators.validateEmptyField(
                                value,
                                "Enter Your Description",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _createTaskInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: _createTask,
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createTask() async {
    if (_formKey.currentState!.validate()) {
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createTask,
        body: {
          "title": _subjectController.text.trim(),
          "description": _descriptionController.text.trim(),
          "status": "New",
        },
      );
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        _subjectController.clear();
        _descriptionController.clear();
        _didTaskCreated = true;
        if (mounted) {
          showSnackMessage(context, "New Task Added!");
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Create New Task Failed! Try Again.", true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
