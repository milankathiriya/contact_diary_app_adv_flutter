import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Future<void> checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isIntroScreenVisited", true);
  }

  @override
  void initState() {
    super.initState();

    checkPrefs();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlutterLogo(size: 160),
            CircularProgressIndicator(),
            Text("Made with ❤️ in India"),
          ],
        ),
      ),
    );
  }
}
