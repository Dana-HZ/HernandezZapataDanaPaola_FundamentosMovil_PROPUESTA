import 'package:flutter/material.dart';
import 'package:journie/features/auth/screens/register_screen.dart';
import 'package:journie/features/auth/widgets/auth_text_field.dart';
import 'package:journie/features/home/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 24),
          child: Column(
            children: [
              const Icon(Icons.filter_vintage, size: 55, color: Color(0xFF8BA9EF)),
              const Text('Journie', style: TextStyle(fontSize: 28, color: Color(0xFF8BA9EF), fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Iniciar sesión', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Bienvenido de nuevo ♡', style: TextStyle(color: Color(0xFF7D879D))),
              ),
              const SizedBox(height: 24),
              const AuthTextField(
                label: 'Correo electrónico',
                hint: 'tucorreo@ejemplo.com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const AuthTextField(
                label: 'Contraseña',
                hint: 'Ingresa tu contraseña',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recuperación de contraseña: próximamente')),
                  ),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  ),
                  child: const Text('Iniciar sesión'),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes una cuenta? '),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text('Regístrate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
