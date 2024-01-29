import 'package:elc_companion_app/screens/landing.screen.dart';
import 'package:elc_companion_app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('app_settings');

  runApp(
    ProviderScope(
      child: MaterialApp(
        onGenerateRoute: (settings) {
          
        },
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const LandingScreen(),
      ),
    ),
  );
}
