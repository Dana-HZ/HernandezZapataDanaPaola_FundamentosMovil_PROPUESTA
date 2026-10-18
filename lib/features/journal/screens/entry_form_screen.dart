import 'package:flutter/material.dart';
import 'package:journie/features/home/models/journal_entry.dart';

class EntryFormScreen extends StatefulWidget {
  final JournalEntry? entry;

  const EntryFormScreen({super.key, this.entry});

  @override
  State<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late DateTime _date;
  String _mood = 'Feliz';
  bool _hasPhoto = false;

  final List<Map<String, dynamic>> _moods = const [
    {'name': 'Feliz', 'icon': Icons.sentiment_very_satisfied},
    {'name': 'Tranquilo', 'icon': Icons.sentiment_satisfied},
    {'name': 'Motivado', 'icon': Icons.wb_sunny_outlined},
    {'name': 'Triste', 'icon': Icons.sentiment_dissatisfied},
    {'name': 'Ansioso', 'icon': Icons.sentiment_neutral},
    {'name': 'Enojado', 'icon': Icons.sentiment_very_dissatisfied},
    {'name': 'Cansado', 'icon': Icons.bedtime_outlined},
    {'name': 'Sorprendido', 'icon': Icons.sentiment_satisfied_alt},
    {'name': 'Agradecido', 'icon': Icons.favorite_border},
  ];

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    _titleController = TextEditingController(text: entry?.title ?? '');
    _contentController = TextEditingController(text: entry?.content ?? '');
    _date = entry?.date ?? DateTime.now();
    _mood = entry?.mood ?? 'Feliz';
    _hasPhoto = entry?.photoPath != null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    final existing = widget.entry;
    final entry = JournalEntry(
      id: existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim().isEmpty ? 'Nueva entrada' : _titleController.text.trim(),
      date: _date,
      mood: _mood,
      content: _contentController.text.trim(),
      photoPath: _hasPhoto ? (existing?.photoPath ?? 'placeholder') : null,
    );
    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(widget.entry == null ? 'Nueva entrada' : 'Editar entrada'),
        actions: [
          TextButton(onPressed: _save, child: const Text('Guardar')),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escribe sobre lo que estás viviendo hoy.', style: TextStyle(color: Color(0xFF8994AA))),
            const SizedBox(height: 22),
            const _FieldLabel('Título'),
            TextField(controller: _titleController, maxLength: 80, decoration: const InputDecoration(hintText: '¿Qué quieres recordar hoy?')),
            const SizedBox(height: 12),
            const _FieldLabel('Fecha'),
            OutlinedButton(
              onPressed: _chooseDate,
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48), alignment: Alignment.centerLeft),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 19),
                  const SizedBox(width: 10),
                  Text('${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}'),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _FieldLabel('Estado de ánimo'),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: _moods.map((mood) {
                final selected = _mood == mood['name'];
                return ChoiceChip(
                  selected: selected,
                  onSelected: (_) => setState(() => _mood = mood['name'] as String),
                  avatar: Icon(mood['icon'] as IconData, size: 19, color: selected ? Colors.white : const Color(0xFF8BA9EF)),
                  label: Text(mood['name'] as String),
                  selectedColor: const Color(0xFF8BA9EF),
                  labelStyle: TextStyle(color: selected ? Colors.white : const Color(0xFF56627A), fontSize: 12),
                  backgroundColor: const Color(0xFFF2F4FB),
                  side: BorderSide(color: selected ? const Color(0xFF7563B5) : const Color(0xFFDCD5F0), width: selected ? 1.5 : 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            const _FieldLabel('Contenido'),
            TextField(
              controller: _contentController,
              minLines: 6,
              maxLines: 10,
              maxLength: 5000,
              decoration: const InputDecoration(hintText: '¿Qué pasó? ¿Cómo te sentiste?', alignLabelWithHint: true),
            ),
            const SizedBox(height: 8),
            const _FieldLabel('Agregar fotografía (opcional)'),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => setState(() => _hasPhoto = !_hasPhoto),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDDE3F1), style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFF9FAFE),
                ),
                child: Column(
                  children: [
                    Icon(_hasPhoto ? Icons.check_circle_outline : Icons.add_photo_alternate_outlined, size: 34, color: const Color(0xFF8BA9EF)),
                    const SizedBox(height: 8),
                    Text(_hasPhoto ? 'Imagen seleccionada (marcador visual)' : 'Toca para agregar una imagen', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 4),
                    const Text('La cámara y la galería se implementarán después.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFF8994AA))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: _save, child: const Text('Guardar entrada')),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF657087), fontSize: 13)),
      );
}
