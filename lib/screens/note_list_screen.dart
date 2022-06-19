import 'package:flutter/material.dart';
import 'package:take_a_note/models/note_model.dart';
import 'package:take_a_note/screens/add_note_screen.dart';
import 'package:take_a_note/screens/filter_note_sceen.dart';
import 'package:take_a_note/services/database_service.dart';
import 'package:take_a_note/widgets/note_tile.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  Future<void> _getNotes() async {
    final notes = await DatabaseService.instance.getAllNotes();
    if (mounted) {
      setState(() {
        _notes = notes;
      });
    }
  }

  Future<void> _getFilterNotes(String filtro) async {
    final filterNotes =
        await DatabaseService.instance.getFilterNotes(filtro: filtro);

    setState(() {
      _notes = filterNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: AppBar(
        backgroundColor: Color(0xffEDEDED),
        elevation: 0,
        title: Text(
          'Mis notas',
          style: Theme.of(context).textTheme.headline5?.merge(TextStyle(
                color: Colors.black,
              )),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => FilterNoteScreen(
                    filterNotes: _getFilterNotes,
                  ),
                )),
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getNotes,
        color: Colors.black,
        child: _notes.length > 0
            ? ListView.separated(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                itemCount: _notes.length,
                itemBuilder: (BuildContext context, int index) {
                  final note = _notes[index];
                  return NoteTile(
                    note: note,
                    updateNotes: _getNotes,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
              )
            : Center(
                child: Text(
                  'Aún no tienes notas.',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8CF35A),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => AddNoteScreen(
                updateNotes: _getNotes,
              ),
            )),
        child: Icon(
          Icons.text_snippet_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
