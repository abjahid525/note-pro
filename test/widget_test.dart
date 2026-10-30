import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notes_pro/main.dart';
import 'package:notes_pro/models/note.dart';
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
}
