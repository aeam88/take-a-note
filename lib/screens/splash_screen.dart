import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:take_a_note/screens/screens.dart';

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
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => NoteListScreen(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 500),
          )
          // MaterialPageRoute(builder: (_) => NoteListScreen()),
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
