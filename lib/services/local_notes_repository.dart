import 'dart:convert';

import 'package:notes_pro/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotesRepository {
  static const _notesKey = 'notes';
  static late LocalNotesRepository instance;

  final SharedPreferences _preferences;

  LocalNotesRepository._(this._preferences);

  static Future<void> initialize() async {
    instance = LocalNotesRepository._(await SharedPreferences.getInstance());
  }

  List<Note> getNotes() {
    final storedNotes = _preferences.getStringList(_notesKey) ?? [];
    return storedNotes
        .map((note) => Note.fromJson(jsonDecode(note) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.creationDate.compareTo(a.creationDate));
  }

  Future<void> saveNote(Note note) async {
    final notes = getNotes();
    final existingIndex = notes.indexWhere((item) => item.id == note.id);
    if (existingIndex >= 0) {
      notes[existingIndex] = note;
    } else {
      notes.add(note);
    }
    await _saveNotes(notes);
  }

  Future<void> deleteNote(String id) async {
    final notes = getNotes()..removeWhere((note) => note.id == id);
    await _saveNotes(notes);
  }

  Future<void> _saveNotes(List<Note> notes) async {
    await _preferences.setStringList(
      _notesKey,
      notes.map((note) => jsonEncode(note.toJson())).toList(),
    );
  }
}
