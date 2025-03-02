import 'package:expenses_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

// ColorScheme class provides .fromseed constructor function to generate a shade of colors based on a base color (seed color).
var kColorTheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkColorTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  // The following line is to ensure that locking the orientation and running the app work as intended.
  WidgetsFlutterBinding.ensureInitialized();
  // Adding then() method because setPreferencesOrientations gives a future
  // making the runApp inside the body of the anonymous function is to make the UI applied once the device orientation is locked.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(
      MaterialApp(
        // Apply theming to the entire application
        // Using the copyWith method to apply the default flutter theme to the application with the ability
        // to override the default values without having to redefine the entire theme
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorTheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorTheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorTheme.primaryContainer,
                foregroundColor: kDarkColorTheme.onPrimaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorTheme,
          // Setting up the default style for the app bar theme
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorTheme.onPrimaryContainer,
              foregroundColor: kColorTheme.primaryFixed),
          // Setting up the default style for the card theme
          cardTheme: const CardTheme().copyWith(
            color: kColorTheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          // Setting up the default style for the elevated buttons
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorTheme.primaryContainer,
            ),
          ),
          // Setting up the default style for the text theme
          textTheme: ThemeData().textTheme.copyWith(
                // Setting up the defualt style for the large titles in the app and using (copy with) to just override the selected parts without
                // redefining the entire object. it depends on how much change you want
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kColorTheme.onSecondaryContainer),
              ),
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  });
}
