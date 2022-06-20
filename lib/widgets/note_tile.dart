import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:take_a_note/models/note_model.dart';
import 'package:take_a_note/screens/screens.dart';
import 'package:take_a_note/services/database_service.dart';

class NoteTile extends StatelessWidget {
  final VoidCallback updateNotes;
  final Note note;

  const NoteTile({required this.note, required this.updateNotes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddNoteScreen(updateNotes: updateNotes, note: note),
          )),
      child: Dismissible(
        onDismissed: (_) {
          DatabaseService.instance.delete(note.id!);
          // updateNotes();
        },
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 25.0),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Color(0xFFFC7474),
          ),
          child: Icon(Icons.delete_outlined),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffDFE1DD),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            key: Key(note.id.toString()),
            minVerticalPadding: 17.0,
            title: Text(
              note.titulo,
              style: Theme.of(context).textTheme.subtitle1?.merge(TextStyle(
                    color: Colors.black,
                  )),
            ),
            subtitle: Text(
              note.contenido,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.merge(TextStyle(color: Color(0xFF444444), fontSize: 12.0)),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color(0xFF211F1F),
                  ),
                  child: Text(
                    EnumToString.convertToString(note.categoria),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.merge(TextStyle(color: Colors.white, fontSize: 13.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
