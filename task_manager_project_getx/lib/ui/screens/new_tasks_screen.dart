import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_getx/ui/controllers/new_task_controller.dart';

import '../../data/models/task_count.dart';
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
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    _newTaskController.getTaskCountSummaryList();
    _newTaskController.getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: GetBuilder<NewTaskController>(
        builder: (controller) => Column(
          children: [
            const ProfileSummeryBar(),
            Visibility(
              visible: controller.getTaskCountSummaryInProgress == false && controller.taskCountSummaryListModel.taskCountList != null,
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.taskCountSummaryListModel.taskCountList?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount = controller.taskCountSummaryListModel.taskCountList![index];
                    return FittedBox(
                      child: SummeryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: controller.getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: refreshScreen,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => TaskItemCard(
                      task: controller.taskListModel.taskList![index],
                      onStatusChange: () {
                        refreshScreen();
                      },
                      onDeleteTask: () {
                        refreshScreen();
                      },
                      showProgress: (inProgress) {
                        controller.getNewTaskInProgress = inProgress;
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: controller.taskListModel.taskList?.length ?? 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            AddNewTaskScreen(
              onBack: refreshScreen,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshScreen() async {
    _newTaskController.getNewTaskList();
    _newTaskController.getTaskCountSummaryList();
  }

  // Future<void> getTaskCountSummaryList() async {
  //   getTaskCountSummaryInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskStatusCount);
  //   if (response.isSuccess) {
  //     taskCountSummaryListModel = TaskCountSummaryListModel.fromJson(response.jsonResponse);
  //   }
  //   getTaskCountSummaryInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // Future<void> getNewTaskList() async {
  //   getNewTaskInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }

  //   final NetworkResponse response = await NetworkCaller().getRequest(
  //     Urls.getNewTasks,
  //   );

  //   if (response.isSuccess) {
  //     taskListModel = TaskListModel.fromJson(response.jsonResponse);
  //   }

  //   getNewTaskInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }
}
