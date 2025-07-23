import 'package:flutter/material.dart';
import 'Colores_page.dart';
import 'package:gestor_tareas_supabase/objet/Task.dart';
import 'package:gestor_tareas_supabase/supabase_funtions/crud_db.dart';


class ItemTask extends StatelessWidget {
  final Task tarea;
  final VoidCallback onTaskUpdate;

  const ItemTask({
    super.key, 
    required this.tarea, 
    required this.onTaskUpdate
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.card,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
          isThreeLine: true,
          title: Text(
            tarea.titulo, 
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColor.textPrimary,
              decoration: tarea.estado 
                ? TextDecoration.lineThrough
                : TextDecoration.none, 
              ),
            ),
          subtitle: Text(
            tarea.descripcion,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.textSecondary,
              decoration: tarea.estado 
                ? TextDecoration.lineThrough
                : TextDecoration.none, 
              ),
            ),

          leading: Checkbox(
            value: tarea.estado,
            activeColor: AppColor.secondary,
            onChanged: (value) async {
              final nuevaTarea = Task(
                id: tarea.id,
                titulo: tarea.titulo,
                descripcion: tarea.descripcion,
                estado: value ?? false,
              );
              await editarTask(nuevaTarea);
              onTaskUpdate(); 
            },
          ),
          
          trailing: Tooltip(
            message: "Eliminar Tarea",
            child: IconButton(
              icon: Icon(Icons.delete, color: AppColor.error,),
              onPressed: () async {
                await eliminarTask(tarea.id);
                onTaskUpdate();
                },
              ), 
            )
          ),
        ),
    );
  }
}