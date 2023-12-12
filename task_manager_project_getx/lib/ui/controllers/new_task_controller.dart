import 'package:get/get.dart';
import 'package:task_manager_project_getx/data/models/task_count_summery_list_model.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool _getTaskCountSummaryInProgress = false;

  set getNewTaskInProgress(bool value) {
    _getNewTaskInProgress = value;
    update();
  }

  TaskListModel _taskListModel = TaskListModel();
  TaskCountSummaryListModel _taskCountSummaryListModel = TaskCountSummaryListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;

  TaskListModel get taskListModel => _taskListModel;
  TaskCountSummaryListModel get taskCountSummaryListModel => _taskCountSummaryListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getNewTasks);

    _getNewTaskInProgress = false;
    update();

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }

  Future<bool> getTaskCountSummaryList() async {
    bool result = false;
    _getTaskCountSummaryInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      _taskCountSummaryListModel = TaskCountSummaryListModel.fromJson(response.jsonResponse);
      result = true;
    }
    _getTaskCountSummaryInProgress = false;
    update();
    return result;
  }
}
