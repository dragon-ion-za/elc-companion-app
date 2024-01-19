import 'package:elc_companion_app/screens/landing.screen.dart';
import 'package:elc_companion_app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const LandingScreen(),
      ),
    ),
  );
}
