import 'package:flutter/material.dart';

final _lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.grey);

final lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: _lightColorScheme.primary
  ),
  scaffoldBackgroundColor: _lightColorScheme.onPrimaryContainer,
  textTheme: ThemeData().textTheme.copyWith().apply(bodyColor: _lightColorScheme.onPrimaryContainer),
  dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: MaterialStatePropertyAll<Color>(_lightColorScheme.secondary)))
).copyWith();
final darkTheme = ThemeData.dark().copyWith();