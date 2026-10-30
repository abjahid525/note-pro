import 'package:flutter_test/flutter_test.dart';

import 'package:notes_pro/main.dart';

void main() {
  test('Notes Pro app exposes the expected root widget', () {
    expect(const NotesProApp(), isA<NotesProApp>());
  });
}
