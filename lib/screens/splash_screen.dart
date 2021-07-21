import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:take_a_note/screens/note_list_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NoteListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        body: Container(
          child: RiveAnimation.asset(
            'assets/rive/take_a_note.riv',
          ),
        ));
  }
}
