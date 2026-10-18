import 'package:flutter/material.dart';

class JournalEntry {
  final String id;
  String title;
  DateTime date;
  String mood;
  String content;
  String? photoPath;

  JournalEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.content,
    this.photoPath,
  });

  String get monthKey => "${date.year}-${date.month}";

  IconData get moodIcon {
    switch (mood) {
      case 'Feliz':
        return Icons.sentiment_very_satisfied;
      case 'Tranquilo':
        return Icons.sentiment_satisfied;
      case 'Motivado':
        return Icons.wb_sunny_outlined;
      case 'Triste':
        return Icons.sentiment_dissatisfied;
      case 'Ansioso':
        return Icons.sentiment_neutral;
      case 'Enojado':
        return Icons.sentiment_very_dissatisfied;
      case 'Cansado':
        return Icons.bedtime_outlined;
      case 'Sorprendido':
        return Icons.sentiment_satisfied_alt;
      case 'Agradecido':
        return Icons.favorite_border;
      default:
        return Icons.mood;
    }
  }

  Color get moodColor {
    switch (mood) {
      case 'Feliz':
      case 'Motivado':
      case 'Agradecido':
        return const Color(0xFF8BA9EF);
      case 'Triste':
      case 'Cansado':
        return const Color(0xFF8A91C8);
      case 'Enojado':
        return const Color(0xFFE59A9A);
      default:
        return const Color(0xFF9CA9C5);
    }
  }
}
