import 'package:flutter/material.dart';
import 'package:journie/features/account/screens/account_screen.dart';
import 'package:journie/features/home/models/journal_entry.dart';
import 'package:journie/features/home/widgets/journal_entry_card.dart';
import 'package:journie/features/journal/screens/entry_detail_screen.dart';
import 'package:journie/features/journal/screens/entry_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final List<JournalEntry> _entries = [];

  Future<void> _openForm() async {
    final entry = await Navigator.push<JournalEntry>(
      context, MaterialPageRoute(builder: (_) => const EntryFormScreen()),
    );
    if (entry != null && mounted) {
      setState(() => _entries.insert(0, entry));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entrada agregada correctamente')),
      );
    }
  }

  Future<void> _openDetail(JournalEntry entry) async {
    final result = await Navigator.push<String>(
      context, MaterialPageRoute(builder: (_) => EntryDetailScreen(entry: entry)),
    );
    if (!mounted) return;
    if (result == 'delete') {
      setState(() => _entries.removeWhere((item) => item.id == entry.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entrada eliminada correctamente')),
      );
    } else if (result == 'updated') {
      setState(() {});
    }
  }

  void _deleteEntry(JournalEntry entry) {
    setState(() => _entries.removeWhere((item) => item.id == entry.id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Entrada eliminada correctamente')),
    );
  }

  String _monthName(int month) {
    const months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [..._entries]..sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      appBar: AppBar(
        title: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Journie', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color(0xFF8B78C6))),
          Text('Tu diario personal', style: TextStyle(fontSize: 11, color: Color(0xFF8994AA))),
        ]),
        actions: [IconButton(tooltip: 'Mi cuenta', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountScreen())), icon: const Icon(Icons.account_circle_outlined, size: 28)), const SizedBox(width: 7)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm, backgroundColor: const Color(0xFF8B78C6), foregroundColor: Colors.white,
        icon: const Icon(Icons.add), label: const Text('Nueva entrada'),
      ),
      body: sorted.isEmpty
          ? ListView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 100),
              children: const [
                SizedBox(height: 55),
                Center(child: Icon(Icons.filter_vintage, size: 55, color: Color(0xFF8BA9EF))),
                SizedBox(height: 18),
                Text('Tu diario está esperando nuevos recuerdos', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color(0xFF37415A))),
                SizedBox(height: 9),
                Text('Cuando quieras guardar un momento, toca “Nueva entrada”.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF8994AA))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 100),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final entry = sorted[index];
                final isNewMonth = index == 0 || sorted[index - 1].monthKey != entry.monthKey;
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (isNewMonth) Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 8),
                    child: Text('${_monthName(entry.date.month)} ${entry.date.year}', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Color(0xFF37415A))),
                  ),
                  JournalEntryCard(entry: entry, onTap: () => _openDetail(entry), onDelete: () => _deleteEntry(entry)),
                ]);
              },
            ),
    );
  }
}
