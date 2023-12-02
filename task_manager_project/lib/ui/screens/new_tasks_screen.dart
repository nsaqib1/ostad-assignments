import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task_list_model.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/network_caller/network_response.dart';
import 'package:task_manager_project/data/utils/urls.dart';

import '../../data/models/task_count.dart';
import '../../data/models/task_count_summery_list_model.dart';
import '../widgets/profile_summery_bar.dart';
import '../widgets/summery_card.dart';
import '../widgets/task_item_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getNewTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  bool getTaskCountSummaryInProgress = false;
  TaskCountSummaryListModel taskCountSummaryListModel =
      TaskCountSummaryListModel();

  @override
  void initState() {
    getTaskCountSummaryList();
    getNewTaskList();
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
          Visibility(
            visible: getTaskCountSummaryInProgress == false &&
                taskCountSummaryListModel.taskCountList != null,
            replacement: const LinearProgressIndicator(),
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      taskCountSummaryListModel.taskCountList?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount =
                        taskCountSummaryListModel.taskCountList![index];
                    return FittedBox(
                      child: SummeryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? '',
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: getNewTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: refreshScreen,
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => TaskItemCard(
                    task: taskListModel.taskList![index],
                    onStatusChange: () {
                      getNewTaskList();
                      getTaskCountSummaryList();
                    },
                    showProgress: (inProgress) {
                      getNewTaskInProgress = inProgress;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: taskListModel.taskList?.length ?? 0,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(
                onBack: refreshScreen,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshScreen() async {
    getNewTaskList();
    getTaskCountSummaryList();
  }

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.getNewTasks,
    );

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
