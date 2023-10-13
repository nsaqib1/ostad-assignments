import 'package:flutter/material.dart';
import 'package:module10_assignment/edit_bottom_sheet.dart';
import 'package:module10_assignment/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Module 10 Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TodoModel> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: "Add Title",
                ),
                validator: _validate,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  hintText: "Add Description",
                ),
                validator: _validate,
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: _addTodo, child: const Text("Add")),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  itemBuilder: (context, index) {
                    final TodoModel todo = _todoList[index];
                    return ListTile(
                      onLongPress: () => _action(index, todo),
                      tileColor: Colors.grey.shade300,
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber.shade900,
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: _todoList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _delete(int index) {
    Navigator.pop(context);
    _todoList.removeAt(index);
    setState(() {});
  }

  _update(int index, TodoModel todo) {
    _todoList[index] = todo;
    setState(() {});
  }

  void _action(int index, TodoModel todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return EditBottomSheet(
                      index: index,
                      todo: todo,
                      update: _update,
                    );
                  },
                );
              },
              child: Text("Edit"),
            ),
            TextButton(
              onPressed: () {
                _delete(index);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _addTodo() {
    if (!_formKey.currentState!.validate()) return;

    final todo = TodoModel(
      title: _titleController.text,
      description: _descController.text,
    );

    _titleController.text = "";
    _descController.text = "";

    _todoList.add(todo);
    setState(() {});
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Value Cannot be Empty!";
    }
    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
