import 'package:flutter/material.dart';

import 'cancelled_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'new_tasks_screen.dart';
import 'progress_tasts_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  void _changeSelectedIndex(int value) {
    _selectedIndex = value;
    setState(() {});
  }

  final List<Widget> _screens = [
    const NewTasksScreen(),
    const ProgressTasksScreen(),
    const CompletedTasksScreen(),
    const CancelledTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _changeSelectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "New",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: "In Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: "Cancelled",
          ),
        ],
      ),
    );
  }
}
