import 'package:flutter_test/flutter_test.dart';
import 'package:notes_pro/models/note.dart';

void main() {
  test('round-trips a note through JSON storage format', () {
    final note = Note(
      id: 'note-1',
      title: 'Study plan',
      content: 'Review Flutter testing',
      creationDate: DateTime(2026, 10, 30, 19, 30),
      colorId: 4,
    );

    final restored = Note.fromJson(note.toJson());

    expect(restored.id, note.id);
    expect(restored.title, note.title);
    expect(restored.content, note.content);
    expect(restored.creationDate, note.creationDate);
    expect(restored.colorId, note.colorId);
  });
}
