import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:take_a_note/screens/note_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take a Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline5: GoogleFonts.redRose(),
          subtitle1: GoogleFonts.redRose(),
          bodyText1: GoogleFonts.redRose(),
          bodyText2: GoogleFonts.openSans(),
        ),
      ),
      home: NoteListScreen(),
    );
  }
}
