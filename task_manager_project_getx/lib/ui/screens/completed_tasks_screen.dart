import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  bool getCompletedTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
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
              visible: getCompletedTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: getCompletedTaskList,
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => TaskItemCard(
                    task: taskListModel.taskList![index],
                    onStatusChange: () {
                      getCompletedTaskList();
                    },
                    onDeleteTask: () {
                      getCompletedTaskList();
                    },
                    showProgress: (inProgress) {
                      getCompletedTaskInProgress = inProgress;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: taskListModel.taskList?.length ?? 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCompletedTaskList() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getCompletedTasks,
    );

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
