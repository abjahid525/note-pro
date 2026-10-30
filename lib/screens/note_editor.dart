import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/services/local_notes_repository.dart';
import 'package:notes_pro/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? noteToEdit;

  const NoteEditorScreen({this.noteToEdit, super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late int colorId;
  late DateTime date;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final note = widget.noteToEdit;
    if (note == null) {
      colorId = Random().nextInt(AppStyle.cardsColor.length);
      date = DateTime.now();
    } else {
      _titleController.text = note.title;
      _mainController.text = note.content;
      colorId = note.colorId;
      date = note.creationDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _mainController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _mainController.text.trim();
    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note is empty!')));
      return;
    }

    try {
      await LocalNotesRepository.instance.saveNote(
        Note(
          id:
              widget.noteToEdit?.id ??
              DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          content: content,
          creationDate: date,
          colorId: colorId,
        ),
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving note: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppStyle.cardsColor[colorId];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.noteToEdit != null ? 'Edit Note' : 'Add a New Note',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 8.0),
            Text(
              DateFormat('dd MMM yyyy, hh:mm a').format(date),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: _saveNote,
        child: const Icon(Icons.save),
      ),
    );
  }
}
