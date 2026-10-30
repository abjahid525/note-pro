import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notes_pro/main.dart';
import 'package:notes_pro/models/note.dart';
import 'package:notes_pro/screens/note_editor.dart';
import 'package:notes_pro/screens/note_reader.dart';
import 'package:notes_pro/services/local_notes_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Notes Pro app exposes the expected root widget', () {
    expect(const NotesProApp(), isA<NotesProApp>());
  });

  testWidgets('cancelling note deletion keeps the reader open', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await LocalNotesRepository.initialize();
    final note = Note(
      id: 'note-1',
      title: 'Keep this note',
      content: 'Content',
      creationDate: DateTime(2026, 1, 1),
      colorId: 1,
    );

    await tester.pumpWidget(MaterialApp(home: NoteReaderScreen(note)));
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text('Delete note?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Keep this note'), findsOneWidget);
    expect(LocalNotesRepository.instance.getNotes(), isEmpty);
  });

  testWidgets('empty notes are not saved', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await LocalNotesRepository.initialize();

    await tester.pumpWidget(const MaterialApp(home: NoteEditorScreen()));
    await tester.tap(find.byIcon(Icons.save));
    await tester.pump();

    expect(find.text('Note is empty!'), findsOneWidget);
    expect(LocalNotesRepository.instance.getNotes(), isEmpty);
  });

  testWidgets('saving a note stores its title and content', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await LocalNotesRepository.initialize();

    await tester.pumpWidget(const MaterialApp(home: NoteEditorScreen()));
    await tester.enterText(
      find.byType(TextField).at(0),
      'Portfolio plan',
    );
    await tester.enterText(
      find.byType(TextField).at(1),
      'Add projects and tests to GitHub.',
    );
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    final notes = LocalNotesRepository.instance.getNotes();
    expect(notes, hasLength(1));
    expect(notes.single.title, 'Portfolio plan');
    expect(notes.single.content, 'Add projects and tests to GitHub.');
  });
}
