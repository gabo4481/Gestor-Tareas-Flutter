class Task {
  final int id;
  final String titulo;
  final String descripcion;
  final bool estado;

  Task({required this.id, required this.titulo, required this.descripcion,required this.estado,});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      estado: json['estado'],
    );
  }
}