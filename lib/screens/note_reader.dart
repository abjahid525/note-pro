import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/screens/note_editor.dart';
import 'package:notes_pro/services/local_notes_repository.dart';
import 'package:notes_pro/style/app_style.dart';

class NoteReaderScreen extends StatelessWidget {
  final Note note;

  const NoteReaderScreen(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppStyle.cardsColor[note.colorId];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(noteToEdit: note),
                ),
              );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () async {
              await LocalNotesRepository.instance.deleteNote(note.id);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: AppStyle.mainTitle),
            const SizedBox(height: 2.0),
            Text(
              DateFormat('dd MMM yyyy, hh:mm a').format(note.creationDate),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 30.0),
            Text(note.content, style: AppStyle.mainContent),
          ],
        ),
      ),
    );
  }
}
