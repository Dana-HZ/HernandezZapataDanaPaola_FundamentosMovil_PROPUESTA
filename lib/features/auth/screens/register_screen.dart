import 'package:flutter/material.dart';
import 'package:journie/features/auth/screens/login_screen.dart';
import 'package:journie/features/auth/widgets/auth_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 4, 25, 24),
          child: Column(
            children: [
              const Icon(Icons.filter_vintage, size: 48, color: Color(0xFF8BA9EF)),
              const Text('Journie', style: TextStyle(fontSize: 26, color: Color(0xFF8BA9EF), fontWeight: FontWeight.w600)),
              const SizedBox(height: 18),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Crear una cuenta', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Únete a nuestra comunidad ♡', style: TextStyle(color: Color(0xFF7D879D))),
              ),
              const SizedBox(height: 20),
              const AuthTextField(label: 'Nombre', hint: 'Tu nombre', icon: Icons.person_outline),
              const AuthTextField(label: 'Apellidos', hint: 'Tus apellidos', icon: Icons.person_outline),
              const AuthTextField(label: 'Correo electrónico', hint: 'tucorreo@ejemplo.com', icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress),
              const AuthTextField(label: 'Contraseña', hint: 'Crea una contraseña', icon: Icons.lock_outline, obscureText: true),
              const AuthTextField(label: 'Confirmar contraseña', hint: 'Repite tu contraseña', icon: Icons.lock_outline, obscureText: true),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  ),
                  child: const Text('Registrarse'),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: Text('¿Ya tienes una cuenta? ')),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text('Inicia sesión'),
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
