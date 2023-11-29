import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  bool getInProgressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  @override
  void initState() {
    getInProgressTaskList();
    super.initState();
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
          const ProfileSummeryBar(),
          Expanded(
            child: Visibility(
              visible: getInProgressTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => TaskItemCard(
                  task: taskListModel.taskList![index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: taskListModel.taskList?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getInProgressTaskList() async {
    getInProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getInProgressTasks,
    );

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getInProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
