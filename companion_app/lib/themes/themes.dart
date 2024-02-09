import 'package:flutter/material.dart';

final _lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.grey);

final lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: _lightColorScheme.primary
  ),
  scaffoldBackgroundColor: _lightColorScheme.primary,
  textTheme: ThemeData().textTheme.copyWith().apply(bodyColor: _lightColorScheme.onPrimaryContainer),
  dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: MaterialStatePropertyAll<Color>(_lightColorScheme.secondary))),
  inputDecorationTheme: InputDecorationTheme().copyWith(floatingLabelStyle: TextStyle().copyWith(color: _lightColorScheme.onBackground),),
  tabBarTheme: TabBarTheme().copyWith(labelColor: _lightColorScheme.onPrimary),
  listTileTheme: ListTileThemeData().copyWith(tileColor: _lightColorScheme.secondary)
).copyWith();
final darkTheme = ThemeData.dark().copyWith();