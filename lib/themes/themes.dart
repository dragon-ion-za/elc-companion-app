import 'package:flutter/material.dart';

final _lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.grey);

final lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: _lightColorScheme.primary
  ),
  scaffoldBackgroundColor: _lightColorScheme.onPrimaryContainer,
  textTheme: ThemeData().textTheme.copyWith().apply(bodyColor: Colors.white)
).copyWith();
final darkTheme = ThemeData.dark().copyWith();