# note-pro

A Flutter notes application connected to Firebase Cloud Firestore. This project demonstrates Flutter UI composition, Firestore streams, note creation, editing, reading, deletion, timestamps, and themed note cards.

## Features

- View notes from a Firestore collection in a two-column grid
- Create notes with a title and body
- Open and read a note
- Edit an existing note
- Delete a note
- Assign a color to each note
- Display note creation dates

## Technology

- Flutter and Dart
- Firebase Cloud Firestore
- Material Design
- Google Fonts
- intl for date formatting

## Current repository status

This repository currently contains the Dart screen and widget source files. It does not yet include the complete Flutter application scaffold, such as `pubspec.yaml`, `lib/main.dart`, Firebase platform configuration files, or automated tests. These files are required before the application can be cloned and run by another developer.

## Required next steps

1. Create a Flutter project scaffold with `flutter create .`.
2. Move application source into the standard `lib/` structure.
3. Add `pubspec.yaml` dependencies for `cloud_firestore`, `firebase_core`, `google_fonts`, and `intl`.
4. Add a `main.dart` entry point and initialize Firebase.
5. Configure Firebase for the target platforms using the Firebase CLI or FlutterFire CLI. Do not commit private credentials or local secrets.
6. Add Firestore security rules and tests.

Until these steps are completed, this repository should be treated as a source snapshot rather than a verified runnable release.
