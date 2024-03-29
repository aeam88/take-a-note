import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:take_a_note/screens/note_list_screen.dart';
// import 'package:take_a_note/screens/splash_screen.dart';

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
          headlineSmall: GoogleFonts.redRose(),
          titleMedium: GoogleFonts.redRose(),
          bodyLarge: GoogleFonts.redRose(),
          bodyMedium: GoogleFonts.openSans(),
        ),
      ),
      // home: Center(child: Text('Prueba')),
      home: NoteListScreen(),
    );
  }
}
