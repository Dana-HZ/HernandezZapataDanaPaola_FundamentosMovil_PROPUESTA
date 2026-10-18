import 'package:flutter/material.dart';
import 'package:journie/features/splash/screens/splash_screen.dart';

void main() {
  runApp(const JournieApp());
}

class JournieApp extends StatelessWidget {
  const JournieApp({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8B78C6);
    return MaterialApp(
      title: 'Journie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFCFBFF),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: purple,
          onPrimary: Colors.white,
          secondary: Color(0xFFB9A9E8),
          onSecondary: Color(0xFF28213D),
          error: Color(0xFFB3261E),
          onError: Colors.white,
          surface: Color(0xFFFCFBFF),
          onSurface: Color(0xFF28334A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFCFBFF),
          foregroundColor: Color(0xFF28334A),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F7FC),
          hintStyle: const TextStyle(color: Color(0xFF9AA5BA), fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E8F2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E8F2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: purple, width: 1.5),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
