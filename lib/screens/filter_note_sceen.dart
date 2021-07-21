import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:take_a_note/models/note_model.dart';
import 'package:take_a_note/services/database_service.dart';

class FilterNoteScreen extends StatefulWidget {
  final Function filterNotes;

  const FilterNoteScreen({required this.filterNotes});

  @override
  _FilterNoteScreenState createState() => _FilterNoteScreenState();
}

class _FilterNoteScreenState extends State<FilterNoteScreen> {
  Categoria? _selectCat = Categoria.sport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffEDEDED),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Filtrar categoría',
            style: Theme.of(context).textTheme.headline5?.merge(TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text('Sport'),
              leading: Radio(
                activeColor: Colors.black,
                value: Categoria.sport,
                groupValue: _selectCat,
                onChanged: (Categoria? value) {
                  setState(() {
                    _selectCat = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Radio(
                activeColor: Colors.black,
                value: Categoria.home,
                groupValue: _selectCat,
                onChanged: (Categoria? value) {
                  setState(() {
                    _selectCat = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('My'),
              leading: Radio(
                activeColor: Colors.black,
                value: Categoria.my,
                groupValue: _selectCat,
                onChanged: (Categoria? value) {
                  setState(() {
                    _selectCat = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Work'),
              leading: Radio(
                activeColor: Colors.black,
                value: Categoria.work,
                groupValue: _selectCat,
                onChanged: (Categoria? value) {
                  setState(() {
                    _selectCat = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Other'),
              leading: Radio(
                activeColor: Colors.black,
                value: Categoria.other,
                groupValue: _selectCat,
                onChanged: (Categoria? value) {
                  setState(() {
                    _selectCat = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF8CF35A),
                    minimumSize: const Size.fromHeight(45.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onPressed: _filtrarCate,
                child: Text(
                  'Filtrar',
                  style: Theme.of(context).textTheme.headline5?.merge(
                        TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                ),
              ),
            ),
          ],
        ));
  }

  void _filtrarCate() {
    // DatabaseService.instance
    //     .getFilterNotes(filtro: EnumToString.convertToString(_selectCat));

    widget.filterNotes(EnumToString.convertToString(_selectCat));

    Navigator.of(context).pop();
  }
}
