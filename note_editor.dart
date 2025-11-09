import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/style/app_style.dart'; // change if your package name differs

class NoteEditorScreen extends StatefulWidget {
  final QueryDocumentSnapshot? docToEdit; // used when editing a note

  const NoteEditorScreen({this.docToEdit, super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late int color_id;
  late Timestamp date;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.docToEdit != null) {
      // 📝 Editing an existing note
      _titleController.text = widget.docToEdit!['note_title'];
      _mainController.text = widget.docToEdit!['note_content'];
      color_id = widget.docToEdit!['color_id'];
      date = widget.docToEdit!['creation_date'];
    } else {
      // ➕ Creating new note
      color_id = Random().nextInt(AppStyle.cardsColor.length);
      date = Timestamp.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.docToEdit != null ? "Edit Note" : "Add a New Note",
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
              DateFormat('dd MMM yyyy, hh:mm a').format(date.toDate()),
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
        child: const Icon(Icons.save),
        onPressed: () async {
          final String title = _titleController.text.trim();
          final String content = _mainController.text.trim();

          if (title.isEmpty && content.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Note is empty!")),
            );
            return;
          }

          try {
            if (widget.docToEdit != null) {
              // 📝 Update note
              await FirebaseFirestore.instance
                  .collection("notes") // 👈 make sure this matches your Firestore collection
                  .doc(widget.docToEdit!.id)
                  .update({
                "note_title": title,
                "note_content": content,
                "creation_date": Timestamp.now(),
                "color_id": color_id,
              });
            } else {
              // ➕ Create new note
              await FirebaseFirestore.instance.collection("notes").add({
                "note_title": title,
                "note_content": content,
                "creation_date": date,
                "color_id": color_id,
              });
            }

            Navigator.pop(context);
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error saving note: $error")),
            );
          }
        },
      ),
    );
  }
}
