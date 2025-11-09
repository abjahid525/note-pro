import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/style/app_style.dart';
import 'package:notes_pro/screens/note_editor.dart';

class NoteReaderScreen extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  const NoteReaderScreen(this.doc, {super.key});

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        actions: [
          // ✏️ EDIT BUTTON
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                    docToEdit: widget.doc, // pass the current note
                  ),
                ),
              );
              Navigator.pop(context); // refresh after returning
            },
          ),
          // 🗑️ DELETE BUTTON
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("notes")
                  .doc(widget.doc.id)
                  .delete();
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
            Text(widget.doc["note_title"], style: AppStyle.mainTitle),
            const SizedBox(height: 2.0),
            Text(
              DateFormat('dd MMM yyyy, hh:mm a')
                  .format((widget.doc["creation_date"] as Timestamp).toDate()),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 30.0),
            Text(widget.doc["note_content"], style: AppStyle.mainContent),
          ],
        ),
      ),
    );
  }
}
