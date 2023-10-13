import 'package:flutter/material.dart';
import 'package:module10_assignment/todo_model.dart';

class EditBottomSheet extends StatefulWidget {
  final int index;
  final TodoModel todo;
  final Function(int, TodoModel) update;
  const EditBottomSheet({
    super.key,
    required this.index,
    required this.todo,
    required this.update,
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.todo.title;
    _descController.text = widget.todo.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.viewInsetsOf(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Padding(
          padding: insets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: "Add Title",
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: "Add Description",
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _update,
                child: Text("Edit Done"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _update() {
    final todo = TodoModel(
      title: _titleController.text,
      description: _descController.text,
    );

    Navigator.pop(context);
    widget.update(widget.index, todo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
