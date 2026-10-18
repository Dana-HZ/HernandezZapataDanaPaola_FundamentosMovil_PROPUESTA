import 'package:flutter/material.dart';
import 'package:journie/features/home/models/journal_entry.dart';
import 'package:journie/features/journal/screens/entry_form_screen.dart';

class EntryDetailScreen extends StatefulWidget {
  final JournalEntry entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  Future<void> _edit() async {
    final updated = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(builder: (_) => EntryFormScreen(entry: widget.entry)),
    );
    if (updated == null || !mounted) return;
    widget.entry
      ..title = updated.title
      ..date = updated.date
      ..mood = updated.mood
      ..content = updated.content
      ..photoPath = updated.photoPath;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cambios actualizados en esta maqueta')));
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar entrada'),
        content: Text('¿Seguro que quieres eliminar "${widget.entry.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirm == true && mounted) Navigator.pop(context, 'delete');
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de entrada'),
        actions: [
          IconButton(tooltip: 'Editar', onPressed: _edit, icon: const Icon(Icons.edit_outlined)),
          IconButton(tooltip: 'Eliminar', onPressed: _delete, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Text('${entry.date.day.toString().padLeft(2, '0')}/${entry.date.month.toString().padLeft(2, '0')}/${entry.date.year}', style: const TextStyle(color: Color(0xFF8994AA))),
          const SizedBox(height: 9),
          Text(entry.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF303A51))),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: entry.moodColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(entry.moodIcon, color: entry.moodColor),
                const SizedBox(width: 9),
                Text(entry.mood, style: TextStyle(color: entry.moodColor, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(entry.content.isEmpty ? 'Esta entrada no tiene contenido todavía.' : entry.content, style: const TextStyle(fontSize: 16, height: 1.7, color: Color(0xFF56627A))),
          if (entry.photoPath != null) ...[
            const SizedBox(height: 24),
            Container(
              height: 190,
              decoration: BoxDecoration(color: const Color(0xFFE9EEFB), borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.image_outlined, color: Color(0xFF8BA9EF), size: 60),
            ),
            const SizedBox(height: 6),
            const Text('Vista previa de fotografía (marcador temporal)', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFF8994AA))),
          ],
          const SizedBox(height: 25),
          OutlinedButton.icon(onPressed: _edit, icon: const Icon(Icons.edit_outlined), label: const Text('Editar entrada')),
        ],
      ),
    );
  }
}
