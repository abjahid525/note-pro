import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/screens/note_editor.dart';
import 'package:notes_pro/screens/note_reader.dart';
import 'package:notes_pro/services/local_notes_repository.dart';
import 'package:notes_pro/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _notes = LocalNotesRepository.instance.getNotes();
    });
  }

  Future<void> _openEditor() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NoteEditorScreen()),
    );
    if (!mounted) return;
    _loadNotes();
  }

  Future<void> _openReader(Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteReaderScreen(note)),
    );
    if (!mounted) return;
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Notes Pro',
          style: GoogleFonts.roboto(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent notes',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _notes.isEmpty
                  ? Center(
                      child: Text(
                        'No notes yet. Add your first note.',
                        style: GoogleFonts.nunito(color: Colors.black54),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        final note = _notes[index];
                        return NoteCard(
                          note: note,
                          onTap: () => _openReader(note),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditor,
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.cyan.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
