import 'package:flutter/material.dart';
import 'package:journie/features/welcome/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1700), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFDCE7FF), Color(0xFF9EB9F6), Color(0xFFECEBFF)],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🦋', style: TextStyle(fontSize: 78)),
            SizedBox(height: 10),
            Text(
              'Journie',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 8),
            Text('Tu espacio personal', style: TextStyle(color: Colors.white)),
            SizedBox(height: 35),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
