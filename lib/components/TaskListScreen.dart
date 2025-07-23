import 'package:flutter/material.dart';
import 'package:gestor_tareas_supabase/objet/Task.dart';
import 'package:gestor_tareas_supabase/supabase_funtions/crud_db.dart';
import 'ItemTask.dart';

class TaskListScreen extends StatefulWidget  {
  const TaskListScreen({super.key});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  Future<List<Task>>? _tareasFuture;

  @override
  void initState(){
    super .initState();
    refreshTasks();
  }


  void refreshTasks() {
    setState(() {
      _tareasFuture = obtenerTasks();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tareasFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar tareas'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay tareas'));
        } else {
          final tareas = snapshot.data!;
          return ListView.builder(
            itemCount: tareas.length,
            itemBuilder: (context, index) {
              final tarea = tareas[index];
              return ItemTask(
                tarea: tarea,
                onTaskUpdate: () => {refreshTasks()},
              );
            },
          );
        }
      },
    );
  }
}