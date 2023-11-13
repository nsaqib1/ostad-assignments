import 'package:flutter/material.dart';

import '../widgets/profile_summery_bar.dart';
import '../widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          ProfileSummeryBar(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => TaskItemCard(),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
