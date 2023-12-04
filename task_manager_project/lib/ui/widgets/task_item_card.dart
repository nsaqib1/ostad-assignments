import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/snackbar_builder.dart';

import '../../data/models/task.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utils/urls.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
    required this.onDeleteTask,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final VoidCallback onDeleteTask;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  late final Task task;

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(widget.task.description ?? ""),
            const SizedBox(height: 10),
            Text(
              "Date: ${task.createdDate}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    task.status ?? "New",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: showDeleteTaskModal,
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: showUpdateStatusModal,
                      icon: const Icon(
                        Icons.edit_note,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteTask() async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.deleteTask(task.sId ?? ""));
    if (response.isSuccess) {
      widget.onDeleteTask();
    } else {
      if (mounted) {
        showSnackMessage(context, "Error! could not delete!");
      }
    }
    widget.showProgress(false);
  }

  void showDeleteTaskModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        actions: [
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
        actions: [
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
