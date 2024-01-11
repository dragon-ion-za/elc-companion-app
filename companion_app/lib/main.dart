import 'package:elc_companion_app/screens/landing_screen.dart';
import 'package:elc_companion_app/themes/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: lightTheme,
    darkTheme: darkTheme,
    home: const LandingScreen(),
  ));
}