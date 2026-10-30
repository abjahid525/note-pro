import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/style/app_style.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({required this.note, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppStyle.cardsColor[note.colorId],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: AppStyle.mainTitle),
            const SizedBox(height: 4.0),
            Text(
              DateFormat('dd MMM yyyy, hh:mm a').format(note.creationDate),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 8.0),
            Text(
              note.content,
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
