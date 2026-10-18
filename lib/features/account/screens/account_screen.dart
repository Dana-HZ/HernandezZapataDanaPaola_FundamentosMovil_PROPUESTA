import 'package:flutter/material.dart';
import 'package:journie/features/account/models/account_data.dart';
import 'package:journie/features/account/screens/edit_account_screen.dart';
import 'package:journie/features/account/widgets/account_info_card.dart';
import 'package:journie/features/welcome/screens/welcome_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountData _account = AccountData(name: '', lastName: '', email: '');

  Future<void> _editAccount() async {
    final updated = await Navigator.push<AccountData>(
      context,
      MaterialPageRoute(builder: (_) => EditAccountScreen(account: _account)),
    );
    if (updated == null || !mounted) return;
    _account
      ..name = updated.name
      ..lastName = updated.lastName
      ..email = updated.email;
    setState(() {});
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Quieres volver a la pantalla de bienvenida?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Cerrar sesión')),
        ],
      ),
    );
    if (confirm == true && mounted) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomeScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const SizedBox(height: 12),
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFE8EEFF),
              child: const Icon(Icons.person_outline, size: 54, color: Color(0xFF8BA9EF)),
            ),
          ),
          const SizedBox(height: 14),
          Center(child: Text(_account.fullName.isEmpty ? 'Tu cuenta' : _account.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF303A51)))),
          const SizedBox(height: 5),
          const Center(child: Text('Tu espacio personal', style: TextStyle(color: Color(0xFF8994AA)))),
          const SizedBox(height: 28),
          AccountInfoCard(label: 'Nombre', value: _account.name.isEmpty ? 'Sin configurar' : _account.name, icon: Icons.person_outline),
          AccountInfoCard(label: 'Apellidos', value: _account.lastName.isEmpty ? 'Sin configurar' : _account.lastName, icon: Icons.badge_outlined),
          AccountInfoCard(label: 'Correo electrónico', value: _account.email.isEmpty ? 'Sin configurar' : _account.email, icon: Icons.mail_outline),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: _editAccount, icon: const Icon(Icons.edit_outlined), label: const Text('Editar información')),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFB66F79)),
          ),
        ],
      ),
    );
  }
}
