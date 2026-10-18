import 'package:flutter/material.dart';
import 'package:journie/features/home/models/journal_entry.dart';

class JournalEntryCard extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const JournalEntryCard({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = '${entry.date.day.toString().padLeft(2, '0')} '
        '${_monthShort(entry.date.month)} ${entry.date.year}';
    final preview = entry.content.trim().isEmpty
        ? 'Sin contenido todavía...'
        : entry.content.trim();

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 22),
        margin: const EdgeInsets.only(bottom: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFF3B8BE),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Eliminar entrada'),
                content: Text('¿Quieres eliminar "${entry.title}"? Esta acción no se puede deshacer.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 13),
        elevation: 1,
        shadowColor: const Color(0x1A5A6A8C),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFEDEFF7)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: entry.moodColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(entry.moodIcon, color: entry.moodColor, size: 25),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF303A51))),
                          const SizedBox(height: 3),
                          Text(dateText, style: const TextStyle(fontSize: 11, color: Color(0xFF8D97AB))),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFFADB5C7)),
                  ],
                ),
                const SizedBox(height: 11),
                Text(
                  preview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.4, fontSize: 13, color: Color(0xFF657087)),
                ),
                if (entry.photoPath != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image_outlined, color: Color(0xFF8BA9EF), size: 34),
                  ),
                ],
                if (entry.photoPath == null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(entry.moodIcon, size: 15, color: entry.moodColor),
                      const SizedBox(width: 5),
                      Text(entry.mood, style: TextStyle(fontSize: 11, color: entry.moodColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _monthShort(int month) {
    const months = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
    return months[month - 1];
  }
}
