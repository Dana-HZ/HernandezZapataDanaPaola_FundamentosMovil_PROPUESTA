import 'package:flutter/material.dart';

class AccountInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const AccountInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFE8EBF4)),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8BA9EF)),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF8994AA))),
        subtitle: Text(value, style: const TextStyle(fontSize: 15, color: Color(0xFF303A51))),
      ),
    );
  }
}
