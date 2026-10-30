import 'package:flutter_test/flutter_test.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/services/local_notes_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalNotesRepository.initialize();
  });

  test('saves and reads notes newest first', () async {
    final olderNote = Note(
      id: 'older',
      title: 'Older note',
      content: 'First',
      creationDate: DateTime(2026, 1, 1),
      colorId: 1,
    );
    final newerNote = Note(
      id: 'newer',
      title: 'Newer note',
      content: 'Second',
      creationDate: DateTime(2026, 2, 1),
      colorId: 2,
    );

    await LocalNotesRepository.instance.saveNote(olderNote);
    await LocalNotesRepository.instance.saveNote(newerNote);

    expect(LocalNotesRepository.instance.getNotes().map((note) => note.id), [
      'newer',
      'older',
    ]);
  });

  test('updates an existing note instead of duplicating it', () async {
    final note = Note(
      id: 'note-1',
      title: 'Original',
      content: 'Before',
      creationDate: DateTime(2026, 1, 1),
      colorId: 1,
    );
    final updatedNote = Note(
      id: 'note-1',
      title: 'Updated',
      content: 'After',
      creationDate: DateTime(2026, 1, 1),
      colorId: 3,
    );

    await LocalNotesRepository.instance.saveNote(note);
    await LocalNotesRepository.instance.saveNote(updatedNote);

    final notes = LocalNotesRepository.instance.getNotes();
    expect(notes, hasLength(1));
    expect(notes.single.title, 'Updated');
    expect(notes.single.colorId, 3);
  });

  test('deletes a note by id', () async {
    await LocalNotesRepository.instance.saveNote(
      Note(
        id: 'note-1',
        title: 'To delete',
        content: 'Content',
        creationDate: DateTime(2026, 1, 1),
        colorId: 1,
      ),
    );

    await LocalNotesRepository.instance.deleteNote('note-1');

    expect(LocalNotesRepository.instance.getNotes(), isEmpty);
  });
}
