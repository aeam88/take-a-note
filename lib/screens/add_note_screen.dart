import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:take_a_note/models/note_model.dart';
import 'package:take_a_note/services/database_service.dart';

class AddNoteScreen extends StatefulWidget {
  final VoidCallback updateNotes;
  final Note? note;

  const AddNoteScreen({required this.updateNotes, this.note});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;

  Note? _note;

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _note = widget.note;
    } else {
      _note = Note(
        titulo: '',
        contenido: '',
        categoria: Categoria.my,
      );
    }

    _tituloController = TextEditingController(text: _note!.titulo);
    _contenidoController = TextEditingController(text: _note!.contenido);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Color(0xffEDEDED),
        centerTitle: true,
        title: Text(
          !_isEditing ? 'Añadir nota' : 'Editar nota',
          style: Theme.of(context).textTheme.headlineSmall?.merge(TextStyle(
                color: Colors.black,
              )),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Debe ingresar un título' : null,
                  onSaved: (value) => _note = _note!.copyWith(titulo: value),
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _contenidoController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Contenido',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) => value!.trim().isEmpty
                      ? 'Debe ingresar un contenido'
                      : null,
                  onSaved: (value) => _note = _note!.copyWith(contenido: value),
                ),
                const SizedBox(height: 32.0),
                DropdownButtonFormField<Categoria>(
                  value: _note!.categoria,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  iconSize: 22.0,
                  items: Categoria.values
                      .map(
                        (categoria) => DropdownMenuItem(
                          value: categoria,
                          child: Text(
                            EnumToString.convertToString(categoria),
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  onChanged: (value) =>
                      setState(() => _note = _note!.copyWith(categoria: value)),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8CF35A),
                      minimumSize: const Size.fromHeight(45.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  onPressed: _submit,
                  child: Text(
                    !_isEditing ? 'Crear nota' : 'Guardar',
                    style: Theme.of(context).textTheme.headlineSmall?.merge(
                          TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (!_isEditing) {
        DatabaseService.instance.insert(_note!);
      } else {
        DatabaseService.instance.update(_note!);
      }

      widget.updateNotes();

      Navigator.of(context).pop();
    }
  }
}
