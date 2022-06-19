import 'package:enum_to_string/enum_to_string.dart';

enum Categoria { all, sport, home, my, work, other }

class Note {
  final int? id;
  final String titulo;
  final String contenido;
  final Categoria categoria;

  const Note({
    this.id,
    required this.titulo,
    required this.contenido,
    required this.categoria,
  });

  Note copyWith({
    int? id,
    String? titulo,
    String? contenido,
    Categoria? categoria,
  }) {
    return Note(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      contenido: contenido ?? this.contenido,
      categoria: categoria ?? this.categoria,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'contenido': contenido,
      'categoria': EnumToString.convertToString(categoria),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      contenido: map['contenido'] as String,
      categoria: EnumToString.fromString(Categoria.values, map['categoria'])!,
    );
  }
}
