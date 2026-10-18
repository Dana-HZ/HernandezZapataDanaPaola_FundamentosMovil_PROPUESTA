import 'package:flutter/material.dart';
import 'package:journie/features/auth/screens/login_screen.dart';
import 'package:journie/features/auth/screens/register_screen.dart';
import 'package:journie/features/home/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EEFF),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.filter_vintage,
                        color: Color(0xFF8BA9EF),
                        size: 70,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'BIENVENIDO A',
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Color(0xFF8793AD),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Journie',
                      style: TextStyle(
                        fontSize: 38,
                        color: Color(0xFF8BA9EF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Tu espacio personal para guardar los momentos que hacen tu vida única.',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.5, color: Color(0xFF4C566D)),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text('Iniciar sesión'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: const Text('Registrarse'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Explorar la app'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
