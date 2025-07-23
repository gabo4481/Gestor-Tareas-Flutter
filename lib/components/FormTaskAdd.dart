import 'package:flutter/material.dart';
import 'package:gestor_tareas_supabase/objet/Task.dart';
import 'package:gestor_tareas_supabase/supabase_funtions/crud_db.dart';
import 'Colores_page.dart';

class FormAddTask extends StatefulWidget {
  final VoidCallback onTaskAdded;
  const FormAddTask({super.key, required this.onTaskAdded});

  @override
  State<FormAddTask> createState() => _FormAddTaskState();
}

class _FormAddTaskState extends State<FormAddTask> {
  final _formKey = GlobalKey<FormState>();
  String _titulo = '';
  String _descripcion = '';
  bool _estado = false;
  bool _loading = false;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      final nuevaTarea = Task(
        id: 0,
        titulo: _titulo,
        descripcion: _descripcion,
        estado: _estado,
      );
      final exito = await agregarTask(nuevaTarea);
      setState(() => _loading = false);
      if (exito) {
        widget.onTaskAdded();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al agregar tarea')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Agregar Tarea'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title, color: AppColor.textSecondary),
                  labelText: 'Título',
                  hintText: 'Escribe el título de la tarea',
                  filled: true,
                  fillColor: AppColor.surface,
                  labelStyle: TextStyle(color: AppColor.textSecondary),
                  hintStyle: TextStyle(color: AppColor.textDisabled),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primaryLight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.error),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => _titulo = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un título' : null,
              ),


              SizedBox(height: 20,),


              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description_outlined, color: AppColor.textSecondary),
                  labelText: 'Descripción',
                  hintText: 'Escribe los detalles de la tarea',

                  filled: true,
                  fillColor: AppColor.surface,
                  labelStyle: TextStyle(color: AppColor.textSecondary),
                  hintStyle: TextStyle(color: AppColor.textDisabled),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primaryLight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.error),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => _descripcion = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese una descripción' : null,
              ),
              Row(
                children: [
                  const Text('Completada'),
                  Checkbox(
                    value: _estado,
                    onChanged: (value) => setState(() => _estado = value ?? false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColor.textSecondary),
          onPressed: _loading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: _loading ? null : _submit,
          child: _loading
            ? const SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,))
            : const Text('Agregar'),
        ),
      ],
    );
  }
}