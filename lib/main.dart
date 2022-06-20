import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:take_a_note/screens/screens.dart';

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
        colorScheme: ColorScheme.light(primary: Colors.black),
        textTheme: TextTheme(
          headline5: GoogleFonts.redRose(),
          subtitle1: GoogleFonts.redRose(),
          bodyText1: GoogleFonts.redRose(),
          bodyText2: GoogleFonts.openSans(),
        ),
      ),
      // home: Center(child: Text('Prueba')),
      home: SplashScreen(),
    );
  }
}
