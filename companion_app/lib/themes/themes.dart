import 'package:flutter/material.dart';

const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF708599),
    onPrimary: Colors.black,
    secondary: Color(0xFF857099),
    onSecondary: Colors.black,
    error: Color(0xFFC40000),
    onError: Colors.white,
    background: Color(0xffe8eef5),
    onBackground: Colors.black,
    surface: Color(0xffa9b7c5),
    onSurface: Colors.black);

final lightTheme = ThemeData(
        colorScheme: _lightColorScheme,
        appBarTheme:
            AppBarTheme().copyWith(backgroundColor: _lightColorScheme.primary),
        scaffoldBackgroundColor: _lightColorScheme.primary,
        textTheme: ThemeData()
            .textTheme
            .copyWith()
            .apply(bodyColor: _lightColorScheme.onPrimaryContainer),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle().copyWith()
        ),
        inputDecorationTheme: InputDecorationTheme().copyWith(
          floatingLabelStyle:
              TextStyle().copyWith(color: _lightColorScheme.onBackground),
        ),
        tabBarTheme:
            TabBarTheme().copyWith(labelColor: _lightColorScheme.onPrimary),
        listTileTheme: ListTileThemeData()
            .copyWith(tileColor: _lightColorScheme.secondaryContainer),
        switchTheme: SwitchThemeData().copyWith(trackColor: MaterialStateProperty.all(_lightColorScheme.secondary)),
        outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle().copyWith(foregroundColor: MaterialStatePropertyAll(Colors.black))))
    .copyWith();
final darkTheme = ThemeData.dark().copyWith();
