import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestor_tareas_supabase/objet/Task.dart';

const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4dXZ3em5maWpyc3djcHV5cmhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxODkyNjEsImV4cCI6MjA2ODc2NTI2MX0.aLYAjk6JnlQdPAqjt_EzxlNtjrfvQWK4DCH7TZf_6-g';
const SUPABASE_KEY_AUTH = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4dXZ3em5maWpyc3djcHV5cmhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxODkyNjEsImV4cCI6MjA2ODc2NTI2MX0.aLYAjk6JnlQdPAqjt_EzxlNtjrfvQWK4DCH7TZf_6-g';

Future<List<Task>> obtenerTasks() async {
  final url = Uri.parse('https://bxuvwznfijrswcpuyrhs.supabase.co/rest/v1/task?select=*');
  try{
    final response = await http.get(
      url,
        headers: {
        'User-Agent': 'FlutterApp/1.0',
        'Accept': 'application/json',
        'apikey': SUPABASE_KEY,
        'Authorization':SUPABASE_KEY_AUTH
      },
    );

    if (response.statusCode == 200) {
        final List<dynamic> datos = jsonDecode(response.body);
        return datos.map((json) => Task.fromJson(json)).toList();
      } else {
        print("Error en la solicitud: ${response.statusCode}");
        return [];
      }
  } catch (e) {
    print("Excepcion al conectarse: $e");
    return [];
  }
}

Future<bool> agregarTask(Task tarea) async {
  final url = Uri.parse('https://bxuvwznfijrswcpuyrhs.supabase.co/rest/v1/task');
  try {
    final response = await http.post(
      url,
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': SUPABASE_KEY_AUTH,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal',
      },
      body: jsonEncode({
        'titulo': tarea.titulo,
        'descripcion': tarea.descripcion,
        'estado': tarea.estado,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      print('Error al agregar tarea: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Excepción al agregar tarea: $e');
    return false;
  }
}

Future<bool> editarTask(Task tarea) async {
  final url = Uri.parse('https://bxuvwznfijrswcpuyrhs.supabase.co/rest/v1/task?id=eq.${tarea.id}');
  try {
    final response = await http.patch(
      url,
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': SUPABASE_KEY_AUTH,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal',
      },
      body: jsonEncode({
        'titulo': tarea.titulo,
        'descripcion': tarea.descripcion,
        'estado': tarea.estado,
      }),
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
      } else {
        print('Error al editar tarea: ${response.statusCode}');
        return false;
      }
  } catch (e) {
    print('Excepción al editar tarea: $e');
    return false;
  }
}

Future<bool> eliminarTask(int id) async {
  final url = Uri.parse('https://bxuvwznfijrswcpuyrhs.supabase.co/rest/v1/task?id=eq.${id}');
  try {
    final response = await http.delete(
      url,
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': SUPABASE_KEY_AUTH,
      },
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
      } else {
        print('Error al eliminar la tarea: ${response.statusCode}');
        return false;
      }
  } catch (e) {
    print('Excepción al eliminar tarea: $e');
    return false;
  }
}