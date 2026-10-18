import 'package:flutter/material.dart';
import 'package:journie/features/account/models/account_data.dart';

class EditAccountScreen extends StatefulWidget {
  final AccountData account;

  const EditAccountScreen({super.key, required this.account});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late final TextEditingController _name;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.account.name);
    _lastName = TextEditingController(text: widget.account.lastName);
    _email = TextEditingController(text: widget.account.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(
      context,
      AccountData(
        name: _name.text.trim().isEmpty ? widget.account.name : _name.text.trim(),
        lastName: _lastName.text.trim().isEmpty ? widget.account.lastName : _lastName.text.trim(),
        email: _email.text.trim().isEmpty ? widget.account.email : _email.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nombre', prefixIcon: Icon(Icons.person_outline))),
          const SizedBox(height: 14),
          TextField(controller: _lastName, decoration: const InputDecoration(labelText: 'Apellidos', prefixIcon: Icon(Icons.badge_outlined))),
          const SizedBox(height: 14),
          TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.mail_outline))),
          const SizedBox(height: 14),
          TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Nueva contraseña (opcional)', prefixIcon: Icon(Icons.lock_outline))),
          const SizedBox(height: 24),
          FilledButton(onPressed: _save, child: const Text('Guardar cambios')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ],
      ),
    );
  }
}
