import 'package:gestor_tareas_supabase/components/Colores_page.dart';
import 'package:flutter/material.dart';
import 'package:gestor_tareas_supabase/components/FormTaskAdd.dart';
import 'package:gestor_tareas_supabase/components/TaskListScreen.dart';

class PageTodoList extends StatefulWidget {
  const PageTodoList({super.key});

  @override
  State<PageTodoList> createState() => _PageTodoList();
}

class _PageTodoList extends State<PageTodoList> {

  final GlobalKey<TaskListScreenState> _taskListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text("Gestor de Tareas"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FormAddTask(
              onTaskAdded: () {
                _taskListKey.currentState?.refreshTasks();
              },
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Agregar Tarea"),
      ),
      body: TaskListScreen(key: _taskListKey),
    );
  }
}