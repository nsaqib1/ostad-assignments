import 'package:flutter/material.dart';

import '../../data/models/task.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
  });

  final Task task;

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
            Text(task.description ?? ""),
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_note,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Colors.red,
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
}
