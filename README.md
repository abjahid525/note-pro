# note-pro

[![Flutter CI](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml/badge.svg)](https://github.com/abjahid525/note-pro/actions/workflows/flutter.yml)

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

The repository now includes a standard Flutter application scaffold, the note screens and widgets under `lib/`, dependency metadata, and a basic Flutter test. Firebase platform configuration is still required before the app can connect to a real Firestore project.

The repository includes a deny-by-default [Firestore rules file](./firestore.rules). Because this version does not use authentication, it intentionally does not permit a deployed Firebase database to be read or changed. This avoids exposing every user's notes through public rules.

## Required next steps

1. Configure Firebase for the target platforms using the Firebase CLI or FlutterFire CLI. Do not commit private credentials or local secrets.
2. Create the `notes` Firestore collection with the fields used by the app: `note_title`, `note_content`, `creation_date`, and `color_id`.
3. Use the Firebase Local Emulator Suite for unauthenticated local development, or add Firebase Authentication before deploying.
4. Replace the deny-by-default rules with per-user rules only after adding authentication and an ownership field such as `owner_id`.
5. Run `flutter analyze` and `flutter test` before publishing a release.

The UI and Dart code are now structured for Flutter, but a real Firebase configuration is still needed for a fully connected release.
